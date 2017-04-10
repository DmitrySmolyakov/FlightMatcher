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
    
    public class func filter(requests: [Request]?, params: Dictionary<String, Any>,
                             success: SuccessHandler, error: ErrorHandler) {
        
        var sortedItems: [Request]?
        
        for (key, value) in params {

            switch key {
            case "cityTo":
                sortedItems = requests?.filter({ $0.to.city == (value as! String) })
            case "cityFrom":
                sortedItems = sortedItems?.filter({ $0.from.city == (value as! String) })
            case "flightNumber":
                sortedItems = sortedItems?.filter({ $0.flightNumber == (value as! String) })

            default: break
            }
        }
       success(sortedItems)
    }
}

