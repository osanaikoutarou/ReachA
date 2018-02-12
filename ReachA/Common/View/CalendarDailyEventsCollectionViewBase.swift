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
    @IBOutlet weak var heightOfCollectionView: NSLayoutConstraint!
    
    var rightToLeft = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareView()
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepareView()
        self.commonInit()
    }
    func prepareView() {
        Bundle.main.loadNibNamed(self.className, owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    func commonInit() {
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventCollectionView.register(cellType: CalendarDailyEventNormalCollectionViewCell.self)
        setRightToLeft()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: 40, height: 40)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        eventCollectionView.collectionViewLayout = layout
        eventCollectionView.contentInset = UIEdgeInsets.zero

        self.layoutIfNeeded()
        heightOfCollectionView.constant = eventCollectionView.contentSize.height
    }
    
    //MARK:--
    
    func setRightToLeft() {
        eventCollectionView.transform = CGAffineTransform(scaleX: -1, y: 1)
        rightToLeft = true
    }
    
    //MARK:-- layout
    
    
    //MARK:-- collectionview
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arc4random() % 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: CalendarDailyEventNormalCollectionViewCell.self, for: indexPath)
        cell.contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
        return cell
    }
}
