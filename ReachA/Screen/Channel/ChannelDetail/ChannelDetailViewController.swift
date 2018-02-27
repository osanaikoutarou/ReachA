//
//  ChannelDetailViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/16.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import WebKit

class ChannelDetailViewController: UIViewController,WKNavigationDelegate {
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    var channel:Channel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let channel = self.channel {
            self.refresh(channel: channel)
        }
    }

    func refresh(channel:Channel) {
        if let url = channel.officialUrl?.url {
            let urlRequest = URLRequest(url: url)
            wkWebView.load(urlRequest)
        }
    }
    
}
