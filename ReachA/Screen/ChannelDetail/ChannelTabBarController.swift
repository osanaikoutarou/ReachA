//
//  ChannelTabBarController.swift
//  ReachA
//
//  Created by osanai on 2018/02/26.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelTabBarController: UITabBarController {

    var channel:Channel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = channel {
            refreshAll()
        }
    }
    
    func setup(with channel:Channel) {
        self.channel = channel
        self.title = channel.name
    }
    
    func refreshAll() {
        let detailVC = getChannelDetailViewController()
        detailVC.channel = self.channel
//        detailVC.refresh(channel: self.channel!)
        let twitterVC = getChannelTwitterViewController()
        twitterVC.channel = self.channel
//        twitterVC.refresh(channel: self.channel!)
    }
    
    func getChannelDetailViewController() -> ChannelDetailViewController {
        return self.viewControllers![1] as! ChannelDetailViewController
    }
    func getChannelTwitterViewController() -> ChannelTwitterViewController {
        return self.viewControllers![2] as! ChannelTwitterViewController
    }

}
