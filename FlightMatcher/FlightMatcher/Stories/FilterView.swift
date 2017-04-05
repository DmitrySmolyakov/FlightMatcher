//
//  FilterView.swift
//  FlightMatcher
//
//  Created by Dasha Korneichuk on 04.04.17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit
import SnapKit

class FilterView: UIView {

    var contentView: UIScrollView?
    var resizableView: UIView?
    
    var cityFromField: UITextField?
    var cityFromLabel: UILabel?
    var cityToField: UITextField?
    var cityToLabel: UILabel?
    var cityPicker: UIPickerView?
    
    var datePicker: UIDatePicker?
    var dateFromLabel: UILabel?
    var dateToLabel: UILabel?
    var dateFromField: UITextField?
    var dateToField: UITextField?
    
    var flightNumberLabel: UILabel?
    var flightNumberField: UITextField?
    
    var filterButton: UIButton?
    
    private func setContentView() {
        contentView = UIScrollView()
        contentView?.isScrollEnabled = true
        self.addSubview(contentView!)
        
        contentView?.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setResizableView() {
        resizableView = UIView()
        resizableView?.backgroundColor = UIColor.white
        contentView?.addSubview(resizableView!)
        
        resizableView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50).priority(250)
        })
    }
    
    private func setPickers() {
        cityPicker = UIPickerView()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
    }
    
    private func setFlightElements() {
        flightNumberLabel = UILabel()
        flightNumberField = UITextField()
        
        flightNumberLabel?.textColor = UIColor.blue
        flightNumberLabel?.textAlignment = .center
        flightNumberLabel?.font = UIFont.systemFont(ofSize: 20)
        contentView?.addSubview(flightNumberLabel!)
        
        flightNumberField?.textAlignment = .center
        contentView?.addSubview(flightNumberField!)
        
        flightNumberLabel?.text = "Flight number"
        flightNumberField?.text = "Not choosen"
        
        flightNumberLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateFromField!).offset(50)
        })
        
        flightNumberField?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(flightNumberLabel!)
            make.top.equalTo(flightNumberLabel!).offset(30)
        })
        
    }

    private func setDateElements() {
        dateFromLabel = UILabel()
        dateToLabel = UILabel()
        dateFromField = UITextField()
        dateToField = UITextField()
        
        let annotationLabels = [dateFromLabel!, dateToLabel!]
        for label in annotationLabels {
            label.textColor = UIColor.blue
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            contentView?.addSubview(label)
        }
        
        let fields = [dateToField, dateFromField]
        for field in fields {
            field?.textAlignment = .center
            field?.isUserInteractionEnabled = true
            contentView?.addSubview(field!)
        }
        
        dateFromLabel?.text = "From date"
        dateToLabel?.text = "To date"
        
        dateFromField?.text = "Not choosen"
        dateToField?.text = "Not choosen"
        
        dateFromLabel?.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(30)
            make.top.equalTo(cityFromField!).offset(70)
            make.width.greaterThanOrEqualTo(100)
        }
        
        dateToLabel?.snp.makeConstraints { (make) -> Void in
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(cityToField!).offset(70)
            make.width.greaterThanOrEqualTo(100)
        }
        
        dateFromField?.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(dateFromLabel!)
            make.top.equalTo(dateFromLabel!).offset(30)
        }
        
        dateToField?.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(dateToLabel!)
            make.top.equalTo(dateToLabel!).offset(30)
        }
        
        dateFromField?.inputView = datePicker
        dateToField?.inputView = datePicker
        
    }
    
    private func setCityElements() {
        cityFromLabel = UILabel()
        cityToLabel = UILabel()
        cityFromField = UITextField()
        cityToField = UITextField()
        
        let annotationLabels = [cityToLabel!, cityFromLabel!]
        for label in annotationLabels {
            label.textColor = UIColor.blue
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            contentView?.addSubview(label)
        }
        
        let fields = [cityToField!, cityFromField!]
        for field in fields {
            field.textAlignment = .center
            field.isUserInteractionEnabled = true
            field.allowsEditingTextAttributes = false
            contentView?.addSubview(field)
        }
        
        cityFromLabel?.text = "From city"
        cityToLabel?.text = "To city"
        
        cityFromField?.text = "Not choosen"
        cityToField?.text = "Not choosen"

        cityFromLabel?.snp.makeConstraints { (make) -> Void in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(95)
            make.width.greaterThanOrEqualTo(100)
        }
        
        cityToLabel?.snp.makeConstraints { (make) -> Void in
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(cityFromLabel!)
            make.width.greaterThanOrEqualTo(100)
        }
        
        cityFromField?.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(cityFromLabel!)
            make.top.equalTo(cityFromLabel!).offset(30)
        }
        
        cityToField?.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(cityToLabel!)
            make.top.equalTo(cityToLabel!).offset(30)
        }
        
        cityFromField?.inputView = cityPicker
        cityToField?.inputView = cityPicker
        
    }
    
    func setFilterButton() {
        filterButton = UIButton(type: .system)
        contentView?.addSubview(filterButton!)
        
        filterButton?.setTitleColor(UIColor.blue, for: .normal)
        filterButton?.showsTouchWhenHighlighted = true
        filterButton?.setTitle("Filter", for: .normal)
        filterButton?.titleLabel?.font = UIFont.systemFont(ofSize: 38)

        filterButton?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateFromField!).offset(150)
        })
        
    }
    
    init() {
        super.init(frame: UIScreen.main.bounds);
        self.backgroundColor = UIColor.white
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


