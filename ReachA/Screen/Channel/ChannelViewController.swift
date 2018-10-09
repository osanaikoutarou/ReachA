//
//  ChannelViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/16.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var channelCollectionView: UICollectionView!

//    var twitterUsers:[TwitterUser] = []
    var channels:[Channel] = JsonLoader.shared.channels

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let interactivePopGestureRecognizer = self.navigationController?.interactivePopGestureRecognizer {
            
            interactivePopGestureRecognizer.cancelsTouchesInView = false
            interactivePopGestureRecognizer.delaysTouchesEnded = false
            interactivePopGestureRecognizer.delaysTouchesEnded = false
        }

        channelCollectionView.delegate = self
        channelCollectionView.dataSource = self
        
        channels = MockData().channels()
        
        channelCollectionView.setupFlowLayout(margin: 20, column: 4, baseSize: CGSize.init(width: 1, height: 1))
        
//        let twitterFetcher = TwitterFetcher()
//        twitterFetcher.fetchUser(
//            screenName: "yurucamp_anime",
//            successHandler: { (tu:TwitterUser) in
//                self.twitterUsers = [tu]
//                self.channelCollectionView.reloadData()
//        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count * 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelCollectionViewCell", for: indexPath) as! ChannelCollectionViewCell
        
        cell.setup(channel: self.channels[indexPath.item % channels.count])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toDetail", sender: channels[indexPath.item % channels.count])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedChannel = sender as! Channel
        let next = segue.destination as! ChannelTabBarController
        next.hidesBottomBarWhenPushed = true
        next.setup(with: selectedChannel)
    }

}
