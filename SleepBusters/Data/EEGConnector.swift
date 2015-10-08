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
    
    override func getSensorData() {
        
    }
    
    func getLiveEEGSensorData() -> EEGSensorStat{
        // Bluetooth code goes here
        return EEGSensorStat()
    }

}