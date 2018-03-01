//
//  ChannelContentVideoTableViewCell.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/01.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelContentVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with video:Video) {
        if video is YoutubeVideo {
            sourceIcon.image = UIImage.init(named: "youtube_social_icon_red")
            thumbnailImageView.sd_setImage(with: self.thumbnailUrl(with: video).url, completed: nil)
            titleLabel.text = video.title
            createdDateLabel.text = "3時間前"
        }
    }
    
    func thumbnailUrl(with video:Video) -> String {
        if video is YoutubeVideo {
            //https://img.youtube.com/vi/0EX3tQWswj0/0.jpg
            let youtubeVideo = video as! YoutubeVideo
            return "https://img.youtube.com/vi/" + youtubeVideo.youtubeId! + "/0.jpg"
        }
        
        return ""
    }


}
