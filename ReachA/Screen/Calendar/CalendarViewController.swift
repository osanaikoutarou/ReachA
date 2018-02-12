//
//  CalendarViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/05.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var calendarTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarTableView.delegate = self
        calendarTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarDailyDayTableViewCell", for: indexPath)
        return cell
    }
    

}
