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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
