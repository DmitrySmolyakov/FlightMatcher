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

        var params = [String: Any]()

        if filterdata?.dateFrom != nil && filterdata?.dateFrom != "" {
            let double = UnixDateConvertor.convert(string: (filterdata?.dateFrom)!, format: "MMM d, h:mm a")
            params["dateFrom"] = UnixDateConvertor.convert(unixtime:double)
        }

        if filterdata?.dateTo != nil && filterdata?.dateTo != "" {
            let double = UnixDateConvertor.convert(string: (filterdata?.dateTo)!, format: "MMM d, h:mm a")
            params["dateTo"] = UnixDateConvertor.convert(unixtime:double)
        }

        if filterdata?.cityTo != nil && filterdata?.cityTo != "" {
            params["cityTo"] = filterdata?.cityTo
        }

        if filterdata?.cityFrom != nil && filterdata?.cityFrom != "" {
            params["cityFrom"] = filterdata?.cityFrom
        }

        if filterdata?.flightNumber != nil && filterdata?.flightNumber != "" {
            params["flightNumber"] = filterData?.flightNumber
        }

        if !params.isEmpty {
            Filter.filter(requests: dataSource, params: params, success: { filtered in
                guard filtered?.count != 0 else {
                    filteredDataSource = dataSource
                    return
                }
                filteredDataSource = filtered
            }, error: { error in })
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightMatchCell.reuseIdentifier(), for: indexPath) as! FlightMatchCell
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
