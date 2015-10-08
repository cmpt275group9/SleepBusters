//
//  Business.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class Business {
    var data = DataAccess()
    
    init(){
       
    }
    
    
    // MARK: User Profile CRUD
    func validateLogin(userName: String,password: String) -> Bool {
        return data.validateLogin(userName,password: password)
    }
    
    func registerUserProfile(user: UserProfile) -> UserProfile {
        return data.registerUserProfile(user)
    }
    
    func getUserProfile(userId: Int) -> UserProfile {
        return data.getUserProfile(userId)
    }
    
    func saveUserProfile(userProfile: UserProfile) -> UserProfile {
        return data.saveUserProfile(userProfile)
    }

    
    // MARK: Repiratory  (Bluetooth)
    func getLiveRespiratorySensorData() -> RespiratorySensorStat{
        return data.getLiveRespiratorySensorData()
    }
    
    func getHistoricalRespiratorySensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [RespiratorySensorStat]{
        return data.getHistoricalRespiratorySensorData(userId, startDate: startDate, endDate: endDate)
    }
    
    func getUserRespiratoryStats(startDate: NSDate, endDate: NSDate) -> [RespiratorySensorStat] {
        return data.getUserRespiratoryStats(startDate,endDate: endDate)
    }
    
    func saveUserRespiratoryStats(stats: [RespiratorySensorStat]) -> StatusResult {
        return data.saveUserRespiratoryStats(stats)
    }
    

    
    // MARK: EEG  (Bluetooth)
    func getLiveEEGSensorData() -> EEGSensorStat{
        return data.getLiveEEGSensorData()
    }
    
    func getHistoricalEEGSensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [EEGSensorStat]{
        return data.getHistoricalEEGSensorData(userId, startDate: startDate, endDate: endDate)
    }
    
    func getEEGStats(startDate: NSDate, endDate: NSDate) -> [EEGSensorStat] {
        return data.getEEGStats(startDate,endDate: endDate)
    }
    
    func saveEEGStats(stats: [EEGSensorStat]) -> StatusResult {
        return data.saveEEGStats(stats)
    }
    
    // MARK: Tracking
    func startTracking(){
        
    }
    
    func stopTracking(){
        
    }
}