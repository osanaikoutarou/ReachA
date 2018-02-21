//
//  ContentEvent.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/19.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers
class ContentEvent: Object {
    
    dynamic var id:String? = nil
    dynamic var start:Date? = nil
    dynamic var end:Date? = nil
    dynamic var title:String? = nil
    dynamic var eventType:String? = nil
    
    dynamic var createAt:Date? = nil
    dynamic var updatedAt:Date? = nil
}

class ContentEventDao: BaseRSDao {
    
    func write() {
        let contentEvent = ContentEvent()
        contentEvent.title = "テスト"
        contentEvent.start = Date()
        
        let realm = try! Realm()
        try! realm.write() {
            realm.add(contentEvent)
        }
    }
    
    func read() {
        let realm = try! Realm()
        let data = realm.objects(ContentEvent.self)
        
        print(data)
    }
    
    func update() {
        let realm = try! Realm()

        let first = realm.objects(ContentEvent.self).first
        
        try! realm.write {
            first?.title = "テストupdated"
        }
    }
    
    func delete() {
        let realm = try! Realm()
        if let first = realm.objects(ContentEvent.self).first {
            try! realm.write {
                realm.delete(first)
            }
        }
    }
}
