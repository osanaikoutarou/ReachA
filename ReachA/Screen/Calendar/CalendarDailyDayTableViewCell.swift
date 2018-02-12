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
//    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventsView: CalendarDailyEventsCollectionViewBase!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        heightConstraint.constant = eventsView.eventCollectionView.collectionViewLayout.collectionViewContentSize.height
    }

}
