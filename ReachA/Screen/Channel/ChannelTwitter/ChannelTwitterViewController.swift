//
//  ChannelTwitterViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/19.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import WebKit
import TwitterKit

class ChannelTwitterViewController: UIViewController {

    @IBOutlet weak var wkWebView: WKWebView!
    
    var channel:Channel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let channel = self.channel {
            self.refresh(channel: channel)
        }
    }
    
    func refresh(channel:Channel) {
        
        if let twitterScreenName = channel.twitterScreenName {
            let twitterTopUrl = "https://twitter.com/" + twitterScreenName + "?lang=ja"
            if let url = twitterTopUrl.url {
                let urlRequest = URLRequest(url: url)
                wkWebView.load(urlRequest)
            }
        }
    }
    
//    func refresh(channel:Channel) {
//        self.channel = channel
//
//        self.showTweetActions = true
//
//        let client = TWTRAPIClient()
//
//        if let twitterScreenName = channel.twitterScreenName {
//            self.dataSource = TWTRUserTimelineDataSource(screenName: twitterScreenName, apiClient: client)
//        }
//
//        self.showTweetActions = true
//    }
    

}
