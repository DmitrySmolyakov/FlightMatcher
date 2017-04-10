//
//  FlightMatchesController.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 4/3/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

protocol FlightMatchDelegate: class {
    func flighMatchesController(_ flighMatchesController: FlightMatchesController, passRequests: [Request]?)
}

class FlightMatchesController: UIViewController {
    
    weak var delegate: FlightMatchDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func filter(_ sender: UIButton) {
      self.presentModally(FilterController())
    }
    
    public var dataSource: [Request]? {
        didSet {
            tableView.reloadData()
            self.delegate?.flighMatchesController(self, passRequests: dataSource)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = getRequests()
    }

    func getRequests() -> [Request]? {
        if let url = Bundle.main.url(forResource: "Request", withExtension: "json") {
            return Request.getRequests(url: url)
        }
        return nil
    }
}

extension FlightMatchesController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightMatchCell.reuseIdentifier(), for: indexPath) as! FlightMatchCell
        let request = dataSource?[indexPath.row]
        cell.configure(item: request!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
