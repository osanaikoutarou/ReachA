//
//  ContentEvent.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/19.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import RealmSwift

class ContentEvent: Object {
    
    @objc dynamic var startDate:Date?
    @objc dynamic var endDate:Date?
    @objc dynamic var title:String?
    
//    required init(startDate:Date, endDate:Date?, title:String) {
//        self.startDate = startDate
//        self.endDate = endDate
//        self.title = title
//    }
    
}

class ContentEventRM: NSObject {
    
}
