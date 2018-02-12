//  
//  CalendarDailyEventsCollectionView.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/11.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class CalendarDailyEventsCollectionViewBase: UIView , UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    var rightToLeft = false

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    func commonInit() {
        eventCollectionView.register(cellType: CalendarDailyEventNormalCollectionViewCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        layout.scrollDirection = .vertical
        eventCollectionView.collectionViewLayout = layout
    }
    
    //MARK:--
    
    func setRightToLeft() {
        eventCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        rightToLeft = true
    }
    
    //MARK:-- layout
    
    
    //MARK:-- collectionview
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CalendarDailyEventNormalCollectionViewCell.self, for: indexPath)
        return cell
    }
}
