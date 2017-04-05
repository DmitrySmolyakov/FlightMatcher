//
//  FilterController.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 04.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit

class FilterController: UIViewController {
    
    var filterView = FilterView()
    var cities: [String]?
 
    override func loadView() {
        super.loadView()
        self.view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       Location.getCities { (parsedCities) in
            self.cities = parsedCities
        }
    }
    
    func setupController() {
        setupPicker()
        setupFields()

        filterView.filterButton?.addTarget(self, action: #selector(filterPressed), for: .touchUpInside)
    }
    
    func filterPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension FilterController: UITextFieldDelegate {
    
    func setupFields() {
        filterView.cityFromField?.delegate = self
        filterView.cityToField?.delegate = self
        filterView.dateFromField?.delegate = self
        filterView.dateToField?.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
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
        filterView.cityFromField?.text = cities?[row]
    }
    
    func setupPicker() {
        filterView.cityPicker?.delegate = self
        filterView.cityPicker?.dataSource = self
    }
}

