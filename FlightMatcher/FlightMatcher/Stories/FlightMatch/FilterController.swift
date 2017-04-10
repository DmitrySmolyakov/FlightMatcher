//
//  FilterController.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 04.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class FilterController: UIViewController {
    
    var cities: [String]?
    var dataSource: [Request]?
    var filterData: FilterData?
    let filterView = FilterView()
 
    override func loadView() {
        super.loadView()
        view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        preloadDataIfPossible()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       Location.getCities { (parsedCities) in
            self.cities = parsedCities
        }
    }
    
    func setupController() {
        setupPicker()
        setupFields()
        filterView.delegate = self
        FlightMatchesController().delegate = self
    }
    
    func preloadDataIfPossible() {
        
        if filterData != nil {
            filterView.cityFromField.text = filterData?.cityFrom
            filterView.cityToField.text = filterData?.cityTo
            filterView.dateFromField.text = filterData?.dateFrom
            filterView.dateToField.text = filterData?.dateTo
            filterView.flightNumberField.text = filterData?.flightNumber
        }
    }
}

extension FilterController: FlightMatchDelegate {
    
    func flighMatchesController(_ flighMatchesController: FlightMatchesController, passRequests: [Request]?) {
        dataSource = [Request]()
        dataSource = passRequests
    }
}

extension FilterController: FilterViewDelegate {
    
    func filterViewDidPressedFilterButton(_ filterView: FilterView) {
        
        filterData = FilterData.init(cityTo: filterView.cityToField.text,
                                   cityFrom: filterView.cityFromField.text,
                                   dateFrom: filterView.dateFromField.text,
                                     dateTo: filterView.dateToField.text,
                               flightNumber: filterView.flightNumberField.text)
        
        let params = ["cityTo": filterData?.cityFrom ?? "",
                      "flightNumber": filterData?.flightNumber ?? "",
                      "dateFrom": UnixDateConvertor.convert(unixtime: 234555555)] as [String : Any]
        
        Filter.filter(requests: dataSource, params: params, success: { filtered in
            print("Filtered - \(filtered?.count ?? 0)")
        }, error: { error in
            print("Error")
        })
        dismiss(animated: true, completion: nil)
    }
}

extension FilterController: UITextFieldDelegate {
    
    func setupFields() {
        filterView.cityFromField.delegate = self
        filterView.cityToField.delegate = self
        filterView.dateFromField.delegate = self
        filterView.dateToField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case filterView.cityToField:
            filterView.cityToPicker.selectRow(0, inComponent: 0, animated: true)
            pickerView(filterView.cityToPicker, didSelectRow: 0, inComponent: 0)
        case filterView.cityFromField:
            filterView.cityFromPicker.selectRow(0, inComponent: 0, animated: true)
            pickerView(filterView.cityFromPicker, didSelectRow: 0, inComponent: 0)
        case filterView.dateFromField:
            if filterView.dateFromField.text == "Not choosen" {
                filterView.dateFromField.text = filterView.dateFromPicker.minimumDate?.toString(withFormat: "MMM d, h:mm a")
            }
        case filterView.dateToField:
            if filterView.dateToField.text == "Not choosen" {
                filterView.dateToField.text = filterView.dateToPicker.minimumDate?.toString(withFormat: "MMM d, h:mm a")
            }
        default:
            break
        }
    }
}

extension FilterController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities?[row]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case filterView.cityFromPicker:
            filterView.cityFromField.text = cities?[row]
        case filterView.cityToPicker:
            filterView.cityToField.text = cities?[row]
        default:
            break
        }
    }
    
    func setupPicker() {
        filterView.cityToPicker.delegate = self
        filterView.cityToPicker.dataSource = self
        
        filterView.cityFromPicker.delegate = self
        filterView.cityFromPicker.dataSource = self
    }
}

