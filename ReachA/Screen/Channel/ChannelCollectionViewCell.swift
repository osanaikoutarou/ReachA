//
//  ChannelCollectionViewCell.swift
//  ReachA
//
//  Created by osanai on 2018/01/16.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var user:TwitterUser?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width/2.0
        iconImageView.clipsToBounds = true
    }
    
    func setup(user:TwitterUser) {
        self.user = user
        
        iconImageView.sd_setImage(with: self.user?.profileImageUrlHttps?.url,
                                  placeholderImage: nil,
                                  options: .retryFailed,
                                  completed: nil)
    }
    
}
