//
//  CalendarCreator.swift
//  ReachA
//
//  Created by 長内幸太郎 on 2018/02/25.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import SwiftDate

class CalendarCreator: NSObject {
    
    // today起点
    func creatDayEvents(from min:Int, to max:Int) -> [DayEvents] {
        
        var result:[DayEvents] = []
        
        for i in min..<max {
            result.append(DayEvents.init(daysAfterToday: i))
        }
        
        return result
    }

}
