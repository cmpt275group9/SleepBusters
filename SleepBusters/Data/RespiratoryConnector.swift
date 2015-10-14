//
//  RespiratoryConnector.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class RespiratoryConnector : HardwareConnector{
    override init() {
        
    }
    func getSensorData() {
        
    }
    
    func getLiveRespiratorySensorData() -> UserSensorStat{
                // Bluetooth code goes here
        return UserSensorStat()
    }
    
}