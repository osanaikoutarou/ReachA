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
    @IBOutlet weak var smallIconView: UIView!
    @IBOutlet weak var smallIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImage.layer.cornerRadius = 20
        iconImage.clipsToBounds = true
        
        smallIconView.layer.cornerRadius = 8
        smallIconView.clipsToBounds = true
        smallIconView.layer.borderColor = UIColor.white.cgColor
        smallIconView.layer.borderWidth = 1
        
        if (arc4random()%2==0) {
            smallIconImageView.image = UIImage.init(named: "icon_play_fill_white")
        }
    }

}
