//
//  DataGenerator.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit
import SwiftyJSON

public class DataGenerator {
    
    public static let shared = DataGenerator()
    
    func parseLocation() -> [Location]? {
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
    
    func parseRequest() -> [Request]? {
        guard let file = Bundle.main.url(forResource: "Request", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: file)
            let json = JSON(data: data)
            
            var requests: [Request]? = [Request]()

            for (index,array):(String, JSON) in json {
                let fromCity = array["from"]["city"].string
                let fromCountry = array["from"]["country"].string
                let fromId = array["from"]["id"].string
                let fromLocation = Location(with: Int(fromId!)!, city: fromCity!, country: fromCountry!)
                
                let toCity = array["to"]["city"].string
                let toCountry = array["to"]["country"].string
                let toId = array["to"]["id"].string
                let toLocation = Location(with: Int(toId!)!, city: toCity!, country: toCountry!)
                
                let flightNumber = array["flightNumber"].string
                let unixNumber = array["date"].string
                let date = Date(timeIntervalSince1970: Double(unixNumber!)!)
                
                let request = Request(with: Int(index)!, from: fromLocation, to: toLocation, date: date, flightNumber: Int(flightNumber!)!)
                requests?.append(request)
            }
            return requests
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
