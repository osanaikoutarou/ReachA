//
//  TimelineViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/15.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import TwitterKit

//SIROyoutuber
class TimelineViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "SIROyoutuber", apiClient: client)
        
        self.showTweetActions = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
