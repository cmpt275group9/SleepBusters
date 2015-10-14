//
//  UserSleepStat.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

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
    var Type: SensorType = SensorType.Generic
    var TimeStamp:  NSDate? = nil
    var CreatedDate:  NSDate? = nil
}

