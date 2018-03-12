//
//  BorderLabel.swift
//  ReachA
//
//  Created by osanai on 2018/03/12.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class BorderLabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        refresh()
    }
    
    func setColor(color:UIColor) {
        self.layer.borderColor = color.cgColor
    }
    
    func refresh() {
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.size.width/2.0
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = self.tintColor.cgColor
    }

}
