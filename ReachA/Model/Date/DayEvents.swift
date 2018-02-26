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
        let now = DateInRegion()
        let target = now + daysAfterToday.day;
        let region = Region(tz: TimeZoneName.asiaTokyo, cal: CalendarName.gregorian, loc: LocaleName.japanese)
        date = DateInRegion(components: [.year:target.year, .month:target.month, .day:target.day], fromRegion: region)
    }

}
