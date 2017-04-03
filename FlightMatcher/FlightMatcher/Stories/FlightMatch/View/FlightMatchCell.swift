//
//  FlightMatchCell.swift
//  FlightMatcher
//
//  Created by Daria Korneichuk on 4/3/17.
//  Copyright © 2017 Dmitry Smolyakov. All rights reserved.
//

import UIKit
import SnapKit

class FlightMatchCell: UITableViewCell {
    
    @IBOutlet weak var fromToLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var flightLabel: UILabel!
    
    class func reuseIdentifier() -> String {
        return String(describing: FlightMatchCell.self)
    }
    
    func configure(withItem item: Any) {
        let request = item as! Request
        self.fromToLabel.text = request.from.country + " " + request.from.city + " - " + request.to.country + " " + request.to.city
        self.dateLabel.text = formatUnixTime(date: request.date)
        self.flightLabel.text = "\(request.flightNumber)"
    }
    
    func formatUnixTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: date)
        return localDate
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeConstraints()
    }

    func makeConstraints() {
        let views = [fromToLabel, dateLabel, flightLabel]

        for view in views {
            view?.snp.makeConstraints { (make) -> Void in
                make.leading.equalTo(superview!).offset(20)
                make.trailing.equalTo(superview!).offset(20)
            }
        }
    }
}
