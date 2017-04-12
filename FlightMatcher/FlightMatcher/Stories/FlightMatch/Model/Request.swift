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
    let from: Location, to: Location
    let dateFrom: Date, dateTo: Date
    let flightNumber: String
    
    init(id: Int, from: Location, to: Location, dateFrom: Date, dateTo: Date, flightNumber: String) {
        self.id = id
        self.from = from
        self.to = to
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.flightNumber = flightNumber
    }
}

extension Request {

    private class func getRequest(index: String, array: JSON) -> Request? {
        guard let id = Int(index) else {
            return nil
        }

        let jsonFrom = array["from"]
        guard let fromLocation = Location(json: jsonFrom) else {
            return nil
        }

        let jsonTo = array["to"]
        guard let toLocation = Location(json: jsonTo) else {
            return nil
        }

        guard let flightNumber = String(array["flightNumber"].stringValue) else {
            return nil
        }

        guard let unixFrom = Double(array["dateFrom"].stringValue) else {
            return nil
        }
        let dateFrom = Date(timeIntervalSince1970: unixFrom)

        guard let unixTo = Double(array["dateTo"].stringValue) else {
            return nil
        }
        let dateTo = Date(timeIntervalSince1970: unixTo)

        let request = Request(id: id, from: fromLocation, to: toLocation,
                              dateFrom: dateFrom, dateTo: dateTo, flightNumber: flightNumber)
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
