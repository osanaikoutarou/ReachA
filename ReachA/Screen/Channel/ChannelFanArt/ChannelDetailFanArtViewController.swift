//
//  ChannelDetailFanArtViewController.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/03/18.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import Swifter

class ChannelDetailFanArtViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var fanartCollectionView: UICollectionView!
    var fanArts:[FanArt] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        fetch()
    }
    
    func setupViews() {
        fanartCollectionView.delegate = self
        fanartCollectionView.dataSource = self
        
        fanartCollectionView .setupFlowLayout(margin: 4, column: 3, baseSize: CGSize.init(width: 100, height: 100))
    }
    
    func fetch() {
        
        TwitterFetcher().searchMedias(using: "ゆるキャン△ filter:images") { (tweets:[Twitter.Tweet]) in

            let addingFanArts = FanArt.initArray(tweets: tweets)
            self.fanArts += addingFanArts
            
            
            self.fanartCollectionView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fanArts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let fanArt = self.fanArts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(with: ChannelDetailFanArtCollectionViewCell.self, for: indexPath)
        
        cell.setup(with: fanArt)
        
        return cell
        
        
        
        
        
        
    }


}
