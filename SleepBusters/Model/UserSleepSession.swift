//
//  UserSleepSession.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-06.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class UserSleepSession : Serializable {
    var Id: Int = 0
    var User: UserProfile = UserProfile()
    var StartSessionDate: NSDate? = nil
    var EndSessionDate:NSDate? = nil
    var TotalHoursAsleep: Double? = nil
}