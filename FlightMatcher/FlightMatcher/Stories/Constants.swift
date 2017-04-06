//
//  Constants.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 05.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

struct Size {
    public static let screenFrame = UIScreen.main.bounds
    public static let screenSize = screenFrame.size
    public static let screenWidth = screenSize.width
    public static let screenHeight = screenSize.height
}

struct Time {
    public static let month = TimeInterval(exactly: 60*60*24*30)
    public static let week = TimeInterval(exactly: 60*60*24*7)
    public static let day = TimeInterval(exactly: 60*60*24)
    public static let hour = TimeInterval(exactly: 60*60)
}
