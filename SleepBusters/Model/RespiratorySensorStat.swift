//
//  RespiratorySensor.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class RespiratorySensorStat : UserSensorStat {
    
    var sleepPositionX: Double? = nil
    var sleepPositionY: Double? = nil
    var sleepPositionZ: Double? = nil

    override init() {
        super.init()
        self.Type = SensorType.Respiratory
    }
}