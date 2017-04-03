//
//  FlightMatchesController.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 4/3/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class FlightMatchesController: UIViewController {
    
}

extension FlightMatchesController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let requests = dataSource()?.count {
            return requests
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightMatchCell.reuseIdentifier(), for: indexPath) as! FlightMatchCell
        let request = dataSource()?[indexPath.row]
        cell.configure(withItem: request as Any)
        return cell
    }
    
    func dataSource() -> [Request]? {
        if let url = Bundle.main.url(forResource: "Request", withExtension: "json") {
            return Request.getRequests(url: url)
        }
        return nil
    }
}
