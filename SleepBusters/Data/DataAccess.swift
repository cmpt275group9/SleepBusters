//
//  Repository.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-02.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation


class DataAccess {
    
    init(){
        
    }
    
    // MARK: Web API Connector (TCP/IP)
    func validateLogin(userName: String,password: String) -> Bool {
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
    
    func getUserRespiratoryStats(startDate: NSDate, endDate: NSDate) -> [RespiratorySensorStat] {
        return WebApiConnector().getUserRespiratoryStats(startDate,endDate: endDate)
    }
    
    func saveUserRespiratoryStats(stats: [RespiratorySensorStat]) -> StatusResult {
        return WebApiConnector().saveUserRespiratoryStats(stats)
    }
    
    func getEEGStats(startDate: NSDate, endDate: NSDate) -> [EEGSensorStat] {
        return WebApiConnector().getEEGStats(startDate,endDate: endDate)
    }
    
    func saveEEGStats(stats: [EEGSensorStat]) -> StatusResult {
        return WebApiConnector().saveEEGStats(stats)
    }
    
    // MARK: Repiratory  (Bluetooth)
    func getLiveRespiratorySensorData() -> RespiratorySensorStat{
        var respiratorySensor = RespiratoryConnector()
        return respiratorySensor.getLiveRespiratorySensorData()
    }
    
    func getHistoricalRespiratorySensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [RespiratorySensorStat]{
        return WebApiConnector().getHistoricalRespiratorySensorData(userId,startDate:startDate,endDate: endDate)
    }
    
    // MARK: EEG  (Bluetooth)
    func getLiveEEGSensorData() -> EEGSensorStat{
        var eegConnector = EEGConnector()
        return eegConnector.getLiveEEGSensorData()
    }
    
    func getHistoricalEEGSensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [EEGSensorStat]{
        return WebApiConnector().getHistoricalEEGSensorData(userId,startDate:startDate,endDate: endDate)
    }
    
}