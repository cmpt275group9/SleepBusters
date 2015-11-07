/********************************************************
 
 UserSleepSession.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This model class represents the UserSleepSession
 table in the database. It will be used to save and display
 user sleep session slee data.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
class UserSleepSession : Serializable {
    var Id: Int = 0
    var User: UserProfile = UserProfile()
    var StartSessionDate: NSDate? = nil
    var EndSessionDate:NSDate? = nil
    var TotalHoursAsleep: Double? = nil
    var TotalDeepSleepHours: Double? = nil
    var TotalAwakeHours: Double? = nil
    var TotalLightSleepHours: Double? = nil
}