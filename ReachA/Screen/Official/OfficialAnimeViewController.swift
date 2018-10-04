//
//  OfficialAnimeViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/27.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import WebKit

class OfficialAnimeViewController: UIViewController {
    
    @IBOutlet weak var wkWebView: WKWebView!

    var channel:Channel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let channel = self.channel {
            self.refresh(channel: channel)
        }
    }
    
    func refresh(channel:Channel) {
        if let url = channel.officialUrl.url {
            let urlRequest = URLRequest(url: url)
            wkWebView.load(urlRequest)
        }
    }

}
