//
//  ChannelTwitterViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/19.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import TwitterKit

class ChannelTwitterViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let client = TWTRAPIClient()
//        self.dataSource = TWTRUserTimelineDataSource(screenName: "SIROyoutuber", apiClient: client)
        self.showTweetActions = true
        
        super.viewDidLoad()
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "yurucamp_anime", apiClient: client)
        
        self.showTweetActions = true
    }
    
    

}
