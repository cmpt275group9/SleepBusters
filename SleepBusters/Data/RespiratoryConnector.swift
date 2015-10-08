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
    override func getSensorData() {
        
    }
    
    func getLiveRespiratorySensorData() -> RespiratorySensorStat{
                // Bluetooth code goes here
        return RespiratorySensorStat()
    }
    
}