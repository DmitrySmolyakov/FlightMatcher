//
//  DateUnixConvertion.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 07.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

public class UnixDateConvertor {

    public class func setFormatter(format: String) -> DateFormatter {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = .current
        return formatter
    }

    public class func convert(date: Date) -> Double {
        return date.timeIntervalSince1970
    }

    public class func convert(string: String, format: String) -> Double {
        let formatter = UnixDateConvertor.setFormatter(format: format)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = formatter.date(from:string)!
        let unixTime = self.convert(date:date)
        return unixTime
    }

    public class func convert(unixtime: Double) -> Date {
        return Date(timeIntervalSince1970: unixtime)
    }

    public class func convert(unixtime: Double, format: String) -> String {
        let unixTimeDate = UnixDateConvertor.convert(unixtime: unixtime)
        let formatter = self.setFormatter(format: format)
            return formatter.string(from: unixTimeDate)
    }

    public class func convert(date: Date, format: String) -> String {
        let unixTime = UnixDateConvertor.convert(date: date)
        let dateString = UnixDateConvertor.convert(unixtime: unixTime, format: format)
        return dateString
    }
}
