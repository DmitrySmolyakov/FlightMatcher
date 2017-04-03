//
//  Request.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit
import SwiftyJSON

class Request {
    let id: Int
    let from: Location
    let to: Location
    let date: Date
    let flightNumber: Int
    
    init(id: Int, from: Location, to: Location, date: Date, flightNumber: Int) {
        self.id = id
        self.from = from
        self.to = to
        self.date = date
        self.flightNumber = flightNumber
    }
}

extension Request {
    private class func getRequest(index: String, array: JSON) -> Request? {
        let jsonFrom = array["from"]
        guard let id = Int(index) else {
            return nil
        }
        guard let fromLocation = Location(json: jsonFrom) else {
            return nil
        }
        
        let jsonTo = array["to"]
        guard let toLocation = Location(json: jsonTo) else {
            return nil
        }
        
        guard let flightNumber = Int(array["flightNumber"].stringValue) else {
            return nil
        }
        guard let unixNumber = Double(array["date"].stringValue) else {
            return nil
        }
        let date = Date(timeIntervalSince1970: unixNumber)
        
        let request = Request(id: id, from: fromLocation, to: toLocation, date: date, flightNumber: flightNumber)
        
        return request
    }
    
    public class func getRequests(url: URL) -> [Request]? {
        do {
            let data = try Data(contentsOf: url)
            let json = JSON(data: data)
            
            var requests: [Request]? = [Request]()
            
            for (index, array):(String, JSON) in json {
                requests?.append(getRequest(index: index, array: array)!)
            }
            return requests
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
