//
//  City.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

let kLocationFile = URL(string: "Cities.json")

class Location {
    
    var ID: Int = 0
    var city: String = ""
    var country: String = ""
    
    init(with ID: Int, city: String, country: String) {
        self.ID = ID
        self.city = city
        self.country = country
    }

}

class Request {
    
    var ID: Int = 0
    var from: Location?
    var to: Location?
    var date: Date = Date()
    var flightNumber: Int = 0
    
}

public class DataGenerator {
    
    public static let shared = DataGenerator()
    
    func readJson() -> [Location]? {
        var locations : [Location]? = [Location]()
        do {
            if let file = Bundle.main.url(forResource: "Cities", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    var id=0
                    for (country,cities) in object {
                        for city in cities as! [Any] {
                            let location = Location(with: id, city: city as! String, country: country)
                            locations?.append(location)
                            id+=1
                        }
                    }
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("No file")
            }
        } catch {
            print(error.localizedDescription)
        }
        return locations
    }
}
