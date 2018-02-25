//
//  CalendarEvent.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/19.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers
class CalendarEvent: Object {
    
    dynamic var id:String? = nil
    dynamic var start:Date? = nil
    dynamic var end:Date? = nil
    dynamic var title:String? = nil
    dynamic var eventType:String? = nil
    
    dynamic var createAt:Date? = nil
    dynamic var updatedAt:Date? = nil
}

class EventDao: BaseRSDao {
    
    func write() {
        let calendarEvent = CalendarEvent()
        calendarEvent.title = "テスト"
        calendarEvent.start = Date()
        
        let realm = try! Realm()
        try! realm.write() {
            realm.add(calendarEvent)
        }
    }
    
    func read() {
        let realm = try! Realm()
        let data = realm.objects(CalendarEvent.self)
        
        print(data)
    }
    
    func update() {
        let realm = try! Realm()

        let first = realm.objects(CalendarEvent.self).first
        
        try! realm.write {
            first?.title = "テストupdated"
        }
    }
    
    func delete() {
        let realm = try! Realm()
        if let first = realm.objects(CalendarEvent.self).first {
            try! realm.write {
                realm.delete(first)
            }
        }
    }
}
