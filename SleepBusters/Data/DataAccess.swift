//
//  Repository.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-02.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation


class DataAccess {
    
    var webApi = WebApiConnector()
    
    init(){
        
    }
    
    // MARK: Web API Connector (TCP/IP)
    func validateLogin(userName: String,password: String) -> UserProfile {
        return WebApiConnector().validateLogin(userName, password: password)
    }
    
    func registerUserProfile(user: UserProfile) -> UserProfile {
        return WebApiConnector().registerUserProfile(user.toDictionary())
    }
    
    func getUserProfile(userId: Int) -> UserProfile {
        return WebApiConnector().getUserProfile(userId)
    }
    
    func saveUserProfile(userProfile: UserProfile) -> UserProfile {
        return WebApiConnector().saveUserProfile(userProfile)
    }
    
    // MARK: Hardware Sensors (Bluetooth)
    func getHistoricalSensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [UserSensorStat]{
        return WebApiConnector().getHistoricalSensorStats(userId, startDate: startDate, endDate: endDate)
    }
    
    func saveUserSensorStats(stats: [UserSensorStat]) -> StatusResult {
        return WebApiConnector().saveUserSensorStats(stats)
    }

    func getLiveSensorData() -> UserSensorStat{
        return HardwareConnector().getLiveSensorData()
    }
    
    
}