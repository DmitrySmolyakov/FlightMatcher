//
//  DataGenerator.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

public class DataGenerator {
    
    public static let shared = DataGenerator()
    
    func readJson() -> [Location]? {
        guard let file = Bundle.main.url(forResource: "Cities", withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let dictionary = json as? [String: Any] else {
                return nil
            }
            var locations: [Location]? = [Location]()
            var cityId = 0
            for (country,cities) in dictionary {
                for city in cities as! [Any] {
                    let location = Location(with: cityId, city: city as! String, country: country)
                    locations?.append(location)
                    cityId+=1
                }
            }
            return locations
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
