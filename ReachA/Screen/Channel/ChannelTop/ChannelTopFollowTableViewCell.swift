//
//  ChannelTopFollowTableViewCell.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/09.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelTopFollowTableViewCell: UITableViewCell {

    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followButton.layer.cornerRadius = followButton.frame.size.height/2.0
        followButton.layer.borderColor = followButton.tintColor.cgColor
        followButton.layer.borderWidth = 1
    }
    
}
