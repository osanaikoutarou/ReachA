//
//  ChannelViewController.swift
//  ReachA
//
//  Created by osanai on 2018/01/16.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChannelCollectionView", for: indexPath)
        
        return cell        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    
    @IBOutlet weak var channelCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        channelCollectionView.delegate = self
        channelCollectionView.dataSource = self
    }
    
    


}
