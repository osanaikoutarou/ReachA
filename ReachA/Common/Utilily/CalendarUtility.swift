//
//  CalendarUtility.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/16.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import SwiftDate

class CalendarUtility: NSObject {
    
    var basicDay:DateInRegion {
        let regionRome = Region(tz: TimeZoneName.asiaTokyo, cal: CalendarName.gregorian, loc: LocaleName.japaneseJapan)
        return DateInRegion(components: [.year : 2017, .month: 2, .day:13], fromRegion: regionRome)!
    }
    
    func day(basicPlus:Int) -> DateInRegion {
        return basicDay + basicPlus.day
    }

}
