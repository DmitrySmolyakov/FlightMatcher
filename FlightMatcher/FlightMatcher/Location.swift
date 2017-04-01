//
//  Location.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class Location {
    let id: Int
    let city: String
    let country: String
    
    init(with id: Int, city: String, country: String) {
        self.id = id
        self.city = city
        self.country = country
    }

}
