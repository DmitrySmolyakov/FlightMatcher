//
//  FilterView.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 04.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit
import SnapKit

protocol FilterViewDelegate: class {
    func filterViewDidPressedFilterButton(_ filterView: FilterView)
}

class FilterView: UIView {
    
    weak var delegate: FilterViewDelegate?

    let contentView = UIScrollView()
    let resizableView = UIView()
    
    let cityFromField = UITextField()
    let cityFromLabel = UILabel()
    let cityToField = UITextField()
    let cityToLabel = UILabel()
    
    let cityFromPicker = UIPickerView()
    let cityToPicker = UIPickerView()
    
    let dateFromPicker = UIDatePicker()
    let dateToPicker = UIDatePicker()
    
    let dateFromLabel = UILabel()
    let dateToLabel = UILabel()
    let dateFromField = UITextField()
    let dateToField = UITextField()
    
    let flightNumberLabel = UILabel()
    let flightNumberField = UITextField()
    
    let filterButton = UIButton()
    
    private func setContentView() {
        contentView.isScrollEnabled = true
        self.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setResizableView() {
        resizableView.backgroundColor = .white
        contentView.addSubview(resizableView)
        
        resizableView.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50).priority(250)
        })
    }
    
    private func setPickers() {
        dateFromPicker.datePickerMode = .dateAndTime
        dateFromPicker.minimumDate = Date()
        dateFromPicker.maximumDate = Date(timeInterval: Double(Time.month)*3, since: Date())
        dateFromPicker.date = dateFromPicker.minimumDate!
        
        dateToPicker.datePickerMode = .dateAndTime
        dateToPicker.minimumDate = Date(timeInterval: Double(Time.hour)*2, since: Date())
        dateToPicker.maximumDate = Date(timeInterval: Double(Time.month)*6, since: Date())
        dateToPicker.date = dateToPicker.minimumDate!
        
        dateToPicker.addTarget(self, action: #selector(handleDateToPicker(sender:)), for: .valueChanged)
        dateFromPicker.addTarget(self, action: #selector(handleDateFromPicker(sender:)), for: .valueChanged)
    }
    
    private func setFlightElements() {
        flightNumberLabel.textColor = .blue
        flightNumberLabel.textAlignment = .center
        flightNumberLabel.font = UIFont.systemFont(ofSize: 20)
        contentView.addSubview(flightNumberLabel)
        
        flightNumberField.textAlignment = .center
        contentView.addSubview(flightNumberField)
        
        flightNumberLabel.text = "Flight number"
        flightNumberField.placeholder = "Number"
        
        flightNumberLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateFromField).offset(50)
        })
        
        flightNumberField.snp.makeConstraints({ (make) in
            make.centerX.equalTo(flightNumberLabel)
            make.top.equalTo(flightNumberLabel).offset(30)
        })
    }

    private func setDateElements() {
        let annotationLabels = [dateFromLabel, dateToLabel]
        for label in annotationLabels {
            label.textColor = .blue
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            contentView.addSubview(label)
        }
        
        let fields = [dateToField, dateFromField]
        for field in fields {
            field.textAlignment = .center
            field.placeholder = "Date"
            field.isUserInteractionEnabled = true
            contentView.addSubview(field)
        }
        
        dateFromLabel.text = "From date"
        dateToLabel.text = "To date"
        
        dateFromLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(cityFromField).offset(70)
            make.width.greaterThanOrEqualTo(100)
        }
        
        dateToLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(cityToField).offset(70)
            make.width.greaterThanOrEqualTo(100)
        }
        
        dateFromField.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(dateFromLabel)
            make.top.equalTo(dateFromLabel).offset(30)
        }
        
        dateToField.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(dateToLabel)
            make.top.equalTo(dateToLabel).offset(30)
        }
        
        dateFromField.inputView = dateFromPicker
        dateToField.inputView = dateToPicker
    }
    
    private func setCityElements() {
        let annotationLabels = [cityToLabel, cityFromLabel]
        for label in annotationLabels {
            label.textColor = .blue
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            contentView.addSubview(label)
        }
        
        let fields = [cityToField, cityFromField]
        for field in fields {
            field.textAlignment = .center
            field.placeholder = "City"
            field.isUserInteractionEnabled = true
            field.allowsEditingTextAttributes = false
            contentView.addSubview(field)
        }
        
        cityFromLabel.text = "From city"
        cityToLabel.text = "To city"

        cityFromLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(95)
            make.width.greaterThanOrEqualTo(100)
        }
        
        cityToLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(cityFromLabel)
            make.width.greaterThanOrEqualTo(100)
        }
        
        cityFromField.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(cityFromLabel)
            make.top.equalTo(cityFromLabel).offset(30)
        }
        
        cityToField.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(cityToLabel)
            make.top.equalTo(cityToLabel).offset(30)
        }
        
        cityFromField.inputView = cityFromPicker
        cityToField.inputView = cityToPicker
    }
    
    func setFilterButton() {
        contentView.addSubview(filterButton)
        
        filterButton.setTitleColor(.blue, for: .normal)
        filterButton.showsTouchWhenHighlighted = true
        filterButton.setTitle("Filter", for: .normal)
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 38)

        filterButton.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateFromField).offset(150)
        })
        
        filterButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func buttonTapped() {
        self.delegate?.filterViewDidPressedFilterButton(self)
    }
    
    func handleDateToPicker(sender: UIDatePicker) {
        dateToField.text = dateToPicker.date.toString(withFormat: "MMM d, h:mm a")
    }
    
    func handleDateFromPicker(sender: UIDatePicker) {
        dateFromField.text = dateFromPicker.date.toString(withFormat: "MMM d, h:mm a")
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds);
        self.backgroundColor = .white
        setContentView()
        setResizableView()
        setPickers()
        setCityElements()
        setDateElements()
        setFlightElements()
        setFilterButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
}


