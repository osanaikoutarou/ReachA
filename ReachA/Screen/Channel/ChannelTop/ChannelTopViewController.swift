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
    
    //MARK:tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return ChannelTopSegmentTableViewCell.height()
        }
        if indexPath.row == 2 {
            return ChannelTopComicTableViewCell.height()
        }
        
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(with: ChannelTopFollowTableViewCell.self, for: indexPath)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(with: ChannelTopSegmentTableViewCell.self, for: indexPath)
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(with: ChannelTopComicTableViewCell.self, for: indexPath)
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(with: SimpleCommonTableViewCell.self, for: indexPath)
            cell.prepareForReuse()
            cell.label1?.text = "type:アニメ"
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(with: SimpleCommonTableViewCell.self, for: indexPath)
            cell.prepareForReuse()
            cell.label1?.text = channel2?.officialUrl
            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(with: SimpleCommonTableViewCell.self, for: indexPath)
            cell.prepareForReuse()
            cell.label1?.text = channel2?.twitterScreenName
            return cell
        }
        if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(with: SimpleCommonTableViewCell.self, for: indexPath)
            cell.prepareForReuse()
            cell.label1?.text = channel2?.wikipedia
            return cell
        }
        if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(with: SimpleCommonTableViewCell.self, for: indexPath)
            cell.prepareForReuse()
            cell.label1?.text = channel2?.descriptionText
            return cell
        }
        if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(with: SimpleCommonTableViewCell.self, for: indexPath)
            cell.label1?.text = "キャラクター"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        if indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(with: SimpleCommonTableViewCell.self, for: indexPath)
            cell.label1?.text = "会社・スタッフ"
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        let cell = UITableViewCell(style: .default, reuseIdentifier: "")
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 6 {
            segueToWikipedia()
        }
    }
    
    //MARK:sege
    
    func segueToWikipedia() {
        performSegue(withIdentifier: "toWikipedia", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toOfficial") {
            let nav = segue.destination as! UINavigationController
            let officialTop = nav.topViewController as! OfficialAnimeViewController
            officialTop.channel = self.channel2
        }
        if (segue.identifier == "toWikipedia") {
//            let wikiVc = segue.destination as! WikipediaViewController
//            wikiVc.setupWithTitle(title: "ゆるキャン△")
        }
        
    }

    //MARK:scrollView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let v = scrollView.contentOffset.y + 300        // なんで60?
        
        channelImageViewTop.constant = min(0, max(-150,-v/2.0))
        channelImageViewHeight.constant = max(300, 300-v)
        
        channelImageView.alpha = min(1.0, (60-(v-300))/60.0)
    }
    

    
}
