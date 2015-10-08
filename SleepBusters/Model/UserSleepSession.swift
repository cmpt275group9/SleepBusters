//
//  UserSleepSession.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-06.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class UserSleepSession {
    var Id: Int = 0
    var StartSessionDate: NSDate = NSDate(dateString:"2000-01-01")
    var EndSessionDate:NSDate = NSDate(dateString:"2000-01-01")
    var TotalHoursAsleep: Double? = nil
    
    init(){
        
    }
}