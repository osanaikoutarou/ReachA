//
//  TopViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/16.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import SDWebImage

class TopViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tappedButton(_ sender: UIButton) {

        let twitterFetcher = TwitterFetcher()
        
        twitterFetcher.fetchUser(
            screenName: "yurucamp_anime",
            successHandler: { (twitterUser:Twitter.User) in
                
                print(twitterUser)
                
                self.nameLabel.text = twitterUser.name
                self.iconImageView.sd_setImage(with: URL(string:twitterUser.profileImageUrlHttps!), completed: nil)
        })
        
        
    }
    
    


}
