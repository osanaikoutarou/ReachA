//
//  ChannelDetailFanArtCollectionViewCell.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/18.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelDetailFanArtCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImageView: UIImageView!
    
    func setup(with fanArt:FanArt) {
        contentImageView.sd_setImage(with: fanArt.firstImageURL().url, completed: nil)
    }
    
}
