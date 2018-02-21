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
    }
    
    @IBAction func tappedButton1(_ sender: Any) {
        
        let dao = ContentEventDao()
        
        dao.write()
        
        dao.read()
        
    }
    
    @IBAction func tappedButton2(_ sender: Any) {
        
        let dao = ContentEventDao()
        
        dao.read()
    }
    

}
