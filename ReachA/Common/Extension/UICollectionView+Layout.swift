//
//  UICollectionView+Layout.swift
//  ReachA
//
//  Created by osanai on 2018/02/26.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    // 何となく均等に配置する
    func setupFlowLayout(margin:CGFloat,column:Int,baseSize:CGSize) {
        self.layoutIfNeeded()
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        layout.minimumInteritemSpacing = margin
        layout.minimumLineSpacing = margin
        let columnF = CGFloat(column)
        let width = ceil((self.frame.size.width - margin * (columnF+1))/columnF) - 1
        layout.itemSize = CGSize.init(width: width, height: width * baseSize.height/baseSize.width)
    }

}
