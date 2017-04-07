//
//  Filter.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 06.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class Filter {
    
    public class func filter(requests: [Request]?, params: Dictionary<String, Any>, success: @escaping ([Request]?) -> Void, failure: @escaping (String) -> Void) {
        
        var sortedItems: [Request]?
        
        for (key, value) in params {
            switch key {
            case "cityTo":
                sortedItems = requests?.filter({ $0.to.city == (value as! String) })
                print(sortedItems?.count ?? 0)
            case "cityFrom":
                sortedItems = requests?.filter({ $0.from.city == (value as! String) })
                print(sortedItems?.count ?? 0)
//            case "dateTo":
//                sortedItems = requests?.filter({$0.dateTo >= (value as! Date) })
//                print(sortedItems?.count ?? 0)
//                fallthrough
//            case "dateFrom":
//                sortedItems = requests?.filter({$0.dateFrom <= (value as! Date) })
//                print(sortedItems?.count ?? 0)
//                fallthrough
            case "flightNumber":
                sortedItems = requests?.filter({ $0.flightNumber == (value as! Int) })
                print(sortedItems?.count ?? 0)
            default:
                print("daefault")
                break
            }
        }
    }

}
