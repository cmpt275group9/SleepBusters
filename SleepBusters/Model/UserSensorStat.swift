//
//  UserSleepStat.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class UserSensorStat {
    var Id: Int = 0
    var Type: SensorType = SensorType.Generic
    var Value: Double? = nil;
    var TimeStamp:  NSDate = NSDate(dateString:"2000-01-01")
    var CreatedDate:  NSDate = NSDate(dateString:"2000-01-01")
}

