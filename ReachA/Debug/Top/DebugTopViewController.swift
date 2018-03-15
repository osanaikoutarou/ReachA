//
//  DebugTopViewController.swift
//  ReachA
//
//  Created by osanai on 2018/02/21.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class DebugTopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let yesterday = DayEvents.init(daysAfterToday: -1)
//        let today = DayEvents.init(daysAfterToday: 0)
//        let tommorow = DayEvents.init(daysAfterToday: 1)
    }
    
    @IBAction func tappedButton1(_ sender: Any) {
        
        let dao = EventDao()
        
        dao.write()
        
        dao.read()
        
    }
    
    @IBAction func tappedButton2(_ sender: Any) {
        
        let dao = EventDao()
        
        dao.read()
    }
    
    @IBAction func tappedTwitterSearchTestButton(_ sender: Any) {
        
        let twitterFetcher = TwitterFetcher()
        twitterFetcher.hoge()

    }
    

}
