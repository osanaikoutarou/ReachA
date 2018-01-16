//
//  ViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/15.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tweetView: TWTRTweetView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        hoge()
        
        kehe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func hoge() {
        let client = TWTRAPIClient()
        client.loadTweet(withID: "952492742596214785") { (tweet, error) in
            if let t = tweet {
                self.tweetView.configure(with: t)
            } else {
                print("Failed to load Tweet: \(error?.localizedDescription)")
            }
        }
    }

    
    func kehe() {
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(session?.userName)");
            } else {
                print("error: \(error?.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    //SIROyoutuber
//    func kehe() {
//        let client = TWTRAPIClient()
//        let dataSource = TWTRListTimelineDataSource(listSlug: "surfing", listOwnerScreenName: "stevenhepting", APIClient: client)
//    }

}

