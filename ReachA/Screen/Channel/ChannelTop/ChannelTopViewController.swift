//
//  ChannelTopViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/27.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelTopViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    
    var channel2:Channel?
    
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelImageViewTop: NSLayoutConstraint!
    @IBOutlet weak var channelImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var channelTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        channelImageView.layoutIfNeeded()
//        channelImageViewHeight.constant = channelImageView.heightWhenFitWidth()
        setupNavBar()
        
        channelTableView.contentInset = UIEdgeInsetsMake(channelImageViewHeight.constant, 0, 0, 0)
        channelTableView.delegate = self
        channelTableView.dataSource = self
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
    
    //MARK:tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    
    //MARK:scrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let v = scrollView.contentOffset.y + 300        // なんで60?
        print(v)
        print("--")
        print(scrollView.contentOffset.y)
        
        channelImageViewTop.constant = min(0, max(-150,-v/2.0))
        channelImageViewHeight.constant = max(300, 300-v)
        
        channelImageView.alpha = min(1.0, (30-(v-270))/30.0)
    }
    
}
