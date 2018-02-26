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
    
    var channel:Channel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width/2.0
        iconImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        iconImageView.layer.cornerRadius = iconImageView.frame.size.width/2.0
        iconImageView.clipsToBounds = true
        super.layoutSubviews()
    }
    
    func setup(channel:Channel) {
        self.channel = channel
        
        channel.setup(completion: { (succeess) in
            if let twitterUser = self.channel?.twitterUser {
                self.iconImageView.sd_setImage(with: twitterUser.profileImageUrlHttps?.url,
                                               placeholderImage: nil,
                                               options: .retryFailed,
                                               completed: nil)
            }
        })
    }
    
}
