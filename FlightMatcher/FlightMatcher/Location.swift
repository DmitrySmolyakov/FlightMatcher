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
    public class func parse(file: String) -> [Location]? {
        guard let file = Bundle.main.url(forResource: file, withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: file)
            let json = JSON(data: data)
            
            var locations: [Location]? = [Location]()
            var cityId = 0
            
            for (country,cities):(String, JSON) in json {
                for (_,city):(String, JSON) in cities {
                    guard let city = city.string else {
                        return nil
                    }
                    let location = Location(id: cityId, city: city, country: country)
                        locations?.append(location)
                        cityId+=1
                    
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
