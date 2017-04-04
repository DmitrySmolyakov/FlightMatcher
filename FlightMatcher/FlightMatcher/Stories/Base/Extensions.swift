//
//  Extensions.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 4/4/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

extension Date {
    func formatUnixTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: self)
        return localDate
    }
}

