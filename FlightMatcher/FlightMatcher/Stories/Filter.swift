//
//  Filter.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 06.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

struct FilterData {
    let cityTo: String?
    let cityFrom: String?
    let dateFrom: String?
    let dateTo: String?
    let flightNumber: String?
}

class Filter {
    typealias SuccessHandler = ([Request]?) -> Void
    typealias ErrorHandler = (String) -> Void

    public class func filter(requests: [Request]?, params: [String: Any],
                             success: SuccessHandler, error: ErrorHandler) {

        var sortedItems: [Request]?

        for (key, value) in params {
            switch key {
            case "cityTo":
                if let toCity = value as? String {
                    sortedItems = requests?.filter({ $0.to.city == toCity })
                }
            case "cityFrom":
                if let cityFrom = value as? String {
                    sortedItems = sortedItems?.filter({ $0.from.city == cityFrom })
                }
            case "flightNumber":
                if let flightNumber = value as? String {
                    sortedItems = sortedItems?.filter({ $0.flightNumber == flightNumber })
                }
            case "dateFrom":
                if let dateFrom = value as? Date {
                    sortedItems = sortedItems?.filter({ $0.dateFrom == dateFrom })
                }
            case "dateTo":
                if let dateTo = value as? Date {
                    sortedItems = sortedItems?.filter({ $0.dateTo == dateTo })
                }
            default: break
            }
        }
       success(sortedItems)
    }
}
