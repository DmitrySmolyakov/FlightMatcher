//
//  FlightMatcherUITests.swift
//  FlightMatcherUITests
//
//  Created by Dmitry Smolyakov on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import XCTest

class FlightMatcherUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        super.tearDown()
    }
}
