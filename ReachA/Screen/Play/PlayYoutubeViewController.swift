//
//  PlayYoutubeViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/01.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import WebKit

class PlayYoutubeViewController: UIViewController {

    @IBOutlet weak var wkWebView: WKWebView!
    
    var youtubeVideo:YoutubeVideo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let youtubeVideo = self.youtubeVideo {
            self.refresh(youtubeVideo: youtubeVideo)
        }
    }
    
    func refresh(youtubeVideo:YoutubeVideo) {
        if let url = youtubeVideo.url?.url {
            let urlRequest = URLRequest(url: url)
            wkWebView.load(urlRequest)
        }
    }

    @IBAction func tappedYoutubeItem(_ sender: UIButton) {
        YoutubeApp().openYoutube(youtubeVideo: youtubeVideo!)
    }
    
}
