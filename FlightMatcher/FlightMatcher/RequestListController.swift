//
//  RequestListController.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 3/31/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class RequestListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let cities = DataGenerator.shared.readJson() {
            for city in cities {
                print(city.ID)
            }
        }
    }

}
