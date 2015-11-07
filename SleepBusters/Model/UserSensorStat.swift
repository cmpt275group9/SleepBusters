/********************************************************
 
 UserSensorStat.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This model class represents the single user sensor
 stata. It will be used to save and display raw user sensor 
 data. 
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
class UserSensorStat : Serializable {
    var Id: Int? = nil
    var User: UserProfile = UserProfile()
    var RespiratoryValue: Double? = nil
    var AmbientTemp: Double? = nil
    var SleepPositionX: Double? = nil
    var SleepPositionY: Double? = nil
    var SleepPositionZ: Double? = nil
    var EegDelta: Int? = nil
    var EegTheta: Int? = nil
    var EegLowAlpha: Int? = nil
    var EegHighAlpha: Int? = nil
    var EegLowBeta: Int? = nil
    var EegHighBeta: Int? = nil
    var EegLowGamma: Int? = nil
    var EegHighGamma: Int? = nil
    var BlinkStrength: Int? = nil
    var DataQuality: Int? = nil;
    var TimeStamp:  NSDate? = nil
    var CreatedDate:  NSDate? = nil
}

