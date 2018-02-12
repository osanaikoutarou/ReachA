//
//  CalendarDailyEventNormalCollectionViewCell.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/11.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class CalendarDailyEventNormalCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImage.layer.cornerRadius = 20
        iconImage.clipsToBounds = true
        
    }

}
