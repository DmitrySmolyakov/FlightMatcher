//
//  FilterController.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 04.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

protocol FilterControllerDelegate: class {
    func filterController(_ filterController: FilterController, returnFilterData: FilterData?)
}

class FilterController: UIViewController {

    convenience init(_ filterData: FilterData?) {
        self.init()
        if filterData != nil {
            self.filterData = filterData
        }
    }

    var cities: [String]?
    var filterData: FilterData?
    let filterView = FilterView()
    weak var delegate: FilterControllerDelegate?

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
       Location.getCities { parsedCities in
            self.cities = parsedCities
        }
    }
}

// MARK: - Setups

extension FilterController {

    func setupController() {
        setupPicker()
        setupFields()
        filterView.delegate = self
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

// MARK: - FilterViewDelegate

extension FilterController: FilterViewDelegate {

    func filterViewDidPressedFilterButton(_ filterView: FilterView) {
        filterData = FilterData.init(cityTo: filterView.cityToField.text,
                                   cityFrom: filterView.cityFromField.text,
                                   dateFrom: filterView.dateFromField.text,
                                     dateTo: filterView.dateToField.text,
                               flightNumber: filterView.flightNumberField.text)

       self.delegate?.filterController(self, returnFilterData: filterData!)
       dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate

extension FilterController: UITextFieldDelegate {

    func setupFields() {
        filterView.cityFromField.delegate = self
        filterView.cityToField.delegate = self
        filterView.dateFromField.delegate = self
        filterView.dateToField.delegate = self
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
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
            if filterView.dateFromField.text?.isEmpty {
                let minimumDate = filterView.dateFromPicker.minimumDate?
                filterView.dateFromField.text = minimumDate.toString(withFormat: "MMM d, h:mm a")
            }
        case filterView.dateToField:
            if filterView.dateToField.text.isEmpty {
                let minimumDate = filterView.dateToPicker.minimumDate?
                filterView.dateToField.text = minimumDate.toString(withFormat: "MMM d, h:mm a")
            }
        default:
            break
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

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
