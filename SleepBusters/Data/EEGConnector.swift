//
//  EEGConnector.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class EEGConnector : HardwareConnector{
    
    override init() {
        
    }
    
    func getSensorData() {
        
    }
    
    func getLiveEEGSensorData() -> UserSensorStat{
        // Bluetooth code goes here
        return UserSensorStat()
    }

}