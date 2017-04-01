//
//  Request.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class Request {
    let id: Int
    let from: Location
    let to: Location
    let date: Date
    let flightNumber: Int
    
    init(with id: Int, from: Location, to: Location, date: Date, flightNumber: Int) {
        self.id = id
        self.from = from
        self.to = to
        self.date = date
        self.flightNumber = flightNumber
    }
    
}
