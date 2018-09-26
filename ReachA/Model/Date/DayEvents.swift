//
//  DayEvents.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/22.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import SwiftDate

class DayEvents: NSObject {
    
    let date:DateInRegion?
    var events:[CalendarEvent] = []
    
    init(daysAfterToday:Int) {
        date = DateInRegion() + daysAfterToday.days
//
//
//
//        let now = DateInRegion()
//        let target = now + daysAfterToday
//        let region = Region(calendar: Calendar(identifier: .gregorian),
//                            zone: TimeZone(identifier: "Asia/Tokyo")!,
//                            locale: Locale(identifier: "ja"))
//        date = DateInRegion(components: [.year:target.year, .month:target.month, .day:target.day], fromRegion: region)
    }

}
