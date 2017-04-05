//
//  Location.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit
import SwiftyJSON

class Location {
    let id: Int
    let city: String
    let country: String

    init(id: Int, city: String, country: String) {
        self.id = id
        self.city = city
        self.country = country
    }
    
    convenience init?(json: JSON) {
        guard let city = json["city"].string else { return nil}
        guard let country = json["country"].string else { return nil}
        guard let id = json["id"].int else { return nil}
    
        self.init(id: id, city: city, country: country)
    }
}

extension Location {
    
    public class func parse(file: String, success:@escaping ([Location]?) -> Void, failure:@escaping (String) -> Void) {
        guard let file = Bundle.main.url(forResource: file, withExtension: "json") else {
            failure("Error in path")
            return
        }
        do {
            let data = try Data(contentsOf: file)
            let json = JSON(data: data)
            
            var locations: [Location]? = [Location]()
            var cityId = 0
            
            for (country, cities):(String, JSON) in json {
                for (_, city):(String, JSON) in cities {
                    guard let city = city.string else {
                        failure("City is not found")
                        return
                    }
                    let location = Location(id: cityId, city: city, country: country)
                        locations?.append(location)
                        cityId += 1
                }
            }
            success(locations)
        } catch {
            failure("Parse error")
        }
    }
    
    public class func getCities(success:@escaping ([String]?) -> Void) {
        parse(file: "Cities", success: { locations in
            var cities = [String]()
            for location in locations! {
                cities.append(location.city)
            }
            success(cities)
        }, failure: { error in
            print(error)
        })
    }
}
