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
    var accounts:[Account] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        channelCollectionView.delegate = self
        channelCollectionView.dataSource = self
        
        
        accounts = MockData().accounts()
        for account in accounts {
            account.setup(completion: { (succeess) in
                channelCollectionView.reloadData()
            })
        }
        
        
        
//        let twitterFetcher = TwitterFetcher()
//        twitterFetcher.fetchUser(
//            screenName: "yurucamp_anime",
//            successHandler: { (tu:TwitterUser) in
//                self.twitterUsers = [tu]
//                self.channelCollectionView.reloadData()
//        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return twitterUsers.count * 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelCollectionViewCell", for: indexPath) as! ChannelCollectionViewCell
        
        cell.setup(user: self.twitterUsers[0])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next:UITabBarController = segue.destination as! UITabBarController
        next.hidesBottomBarWhenPushed = true
        next.title = "ゆるキャン△"
    }

}
