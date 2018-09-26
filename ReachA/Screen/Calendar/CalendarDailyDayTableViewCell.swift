//
//  CalendarDailyDayTableViewCell.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/05.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class CalendarDailyDayTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayofweekLabel: UILabel!
    
//    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventsView: CalendarDailyEventsCollectionViewBase!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(with dayEvents:DayEvents) {
        
        if let dayStr = dayEvents.date?.day {
            dayLabel.text = String(describing: dayStr)
        }
        
        dayofweekLabel.text = dayEvents.date?.weekdayName(.default).sw4substring(to: 1)
    }
}
