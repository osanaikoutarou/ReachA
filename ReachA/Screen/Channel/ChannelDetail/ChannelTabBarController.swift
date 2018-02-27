//
//  ChannelTabBarController.swift
//  ReachA
//
//  Created by osanai on 2018/02/26.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelTabBarController: UITabBarController {

    var channel1:Channel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = channel1 {
            refreshAll()
        }
    }
    
    func setup(with channel:Channel) {
        self.channel1 = channel
        self.title = channel.name
    }
    
    func refreshAll() {
        guard let channel = self.channel1 else {
            return
        }
        
        let topVC:ChannelTopViewController = getChannelTopViewController()
        topVC.channel2 = channel
//        let detailVC = getChannelDetailViewController()
//        detailVC.channel = self.channel
        let twitterVC:ChannelTwitterViewController = getChannelTwitterViewController()
        twitterVC.channel = channel
        
        
    }

    func getChannelTopViewController() -> ChannelTopViewController {
        return self.viewControllers![0] as! ChannelTopViewController
    }
//    func getChannelDetailViewController() -> ChannelDetailViewController {
//        return self.viewControllers![1] as! ChannelDetailViewController
//    }
    func getChannelTwitterViewController() -> ChannelTwitterViewController {
        return self.viewControllers![2] as! ChannelTwitterViewController
    }

}
