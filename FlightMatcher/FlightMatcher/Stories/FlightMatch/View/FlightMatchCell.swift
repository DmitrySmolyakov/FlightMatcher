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
    
    func configure(item: Request) {
        fromToLabel.text = "\(item.from.country) \(item.from.city) - \(item.to.country) \(item.to.city)"
        dateLabel.text = "\(item.dateFrom.formatUnixTime()) - \(item.dateTo.formatUnixTime()) "
        flightLabel.text = "\(item.flightNumber)"
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
