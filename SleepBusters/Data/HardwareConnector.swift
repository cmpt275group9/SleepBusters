//
//  ArduinoConnector.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class HardwareConnector {
    init ()
    {
        
    }
    
    func getLiveSensorData() -> UserSensorStat{
        var userSensorStream = UserSensorStat()
        userSensorStream = getEegSensorData(userSensorStream)
        userSensorStream = getRespiratorySensorData(userSensorStream)
        return userSensorStream
    }
    
    func getEegSensorData(userSensorStat: UserSensorStat)-> UserSensorStat{
        // Bluetooth code goes here
        return UserSensorStat()
    }
    
    func getRespiratorySensorData(userSensorStat:UserSensorStat)-> UserSensorStat{
        // Bluetooth code goes here
        return UserSensorStat()
    }
    
}