//
//  CircleImageView.swift
//  ReachA
//
//  Created by osanai on 2018/03/12.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

    override func awakeFromNib() {
        self.layoutIfNeeded()
        circle()
    }
    
    func circle() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2.0
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        circle()
    }
}
