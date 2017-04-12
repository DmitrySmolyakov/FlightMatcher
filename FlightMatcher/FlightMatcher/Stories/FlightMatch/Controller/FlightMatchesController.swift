//
//  FlightMatchesController.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 4/3/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class FlightMatchesController: UIViewController {

    var filterData: FilterData?

    @IBOutlet weak var tableView: UITableView!

    @IBAction func filter(_ sender: UIButton) {
        let vc = FilterController(filterData)
        vc.delegate = self
        self.presentModally(vc)
    }

    public var dataSource: [Request]? {
        didSet {
            tableView.reloadData()
        }
    }

    public var filteredDataSource: [Request]? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        filter(filterdata: self.filterData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
}

// MARK: - Setups

extension FlightMatchesController {

    func getRequests() -> [Request]? {
        if let url = Bundle.main.url(forResource: "Request", withExtension: "json") {
            return Request.getRequests(url: url)
        }
        return nil
    }

    func filter(filterdata: FilterData?) {
        Filter.filter(requests: dataSource, params: self.filterData!, success: { filtered in
            if let filtered = filtered {
                filteredDataSource = filtered
            } else {
                filteredDataSource = nil
            }
        }, error: { _ in })
    }

    func setupController() {
        dataSource = getRequests()
        filteredDataSource = dataSource
        filterData = FilterData(cityTo: nil, cityFrom: nil, dateFrom: nil, dateTo: nil, flightNumber: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FlightMatchesController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightMatchCell.reuseIdentifier(),
                                                 for: indexPath) as! FlightMatchCell
        let request = filteredDataSource?[indexPath.row]
        cell.configure(item: request!)
        return cell
    }
}

// MARK: - FilterViewDelegate

extension FlightMatchesController: FilterControllerDelegate {

    func filterController(_ filterController: FilterController, returnFilterData: FilterData?) {
        self.filterData = returnFilterData
    }
}
