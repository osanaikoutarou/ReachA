//
//  ChannelVideosViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/01.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelVideosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    var video:YoutubeVideo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        // sample
        video = YoutubeVideo()
        video?.youtubeId = "0EX3tQWswj0"
        video?.title = "佐々木恵梨『ふゆびより』 (Music Video) TVアニメ「ゆるキャン」EDテーマ"
        video?.url = "https://www.youtube.com/watch?v=0EX3tQWswj0"
    }
    
    //MARK:tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ChannelContentVideoTableViewCell.self, for: indexPath)
        cell .setup(with: video!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        self.tabBarController?.performSegue(withIdentifier: "toPlayYoutube", sender: nil)
        self.performSegue(withIdentifier: "toPlayYoutube", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PlayYoutubeViewController
        vc.youtubeVideo = video!
    }
    

}
