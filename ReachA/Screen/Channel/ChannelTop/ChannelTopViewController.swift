//
//  ChannelTopViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/27.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelTopViewController: UIViewController {

    var channel2:Channel?
    
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelImageViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        channelImageView.layoutIfNeeded()
        channelImageViewHeight.constant = channelImageView.heightWhenFitWidth()

        setupNavBar()
    }
    
    func setupNavBar() {
        self.navigationController?.title = ""
        clearNavBar()
    }
    func clearNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction func tappedOfficialButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toOfficial", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as! UINavigationController
        let officialTop = nav.topViewController as! OfficialAnimeViewController
        officialTop.channel = self.channel2
    }
    

}
