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

    public class func filter(requests: [Request]?, params: FilterData,
                             success: SuccessHandler, error: ErrorHandler) {

        var sortedItems = requests

        if let cityTo = params.cityTo, !cityTo.isEmpty {
            sortedItems = sortedItems?.filter({ $0.to.city == cityTo })
        }

        if let cityFrom = params.cityFrom, !cityFrom.isEmpty {
            sortedItems = sortedItems?.filter({ $0.from.city == cityFrom })
        }

        if let flightNumber = params.flightNumber, !flightNumber.isEmpty {
            sortedItems = sortedItems?.filter({ $0.flightNumber == flightNumber })
        }

        if let dateFrom = params.dateFrom, !dateFrom.isEmpty {
            let doubleDate = UnixDateConvertor.convert(string: dateFrom, format: "MMM d, h:mm a")
            let date = UnixDateConvertor.convert(unixtime: doubleDate)
            sortedItems = sortedItems?.filter({ $0.dateFrom == date })
        }

        if let dateTo = params.dateTo, !dateTo.isEmpty {
            let doubleDate = UnixDateConvertor.convert(string: dateTo, format: "MMM d, h:mm a")
            let date = UnixDateConvertor.convert(unixtime: doubleDate)
            sortedItems = sortedItems?.filter({ $0.dateTo == date })
        }

       success(sortedItems)
    }
}
