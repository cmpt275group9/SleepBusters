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
    var sensorStatArray = [UserSensorStat]()
    var userSleepSession = UserSleepSession()
    init(){
       
    }
    
    
    // MARK: User Profile CRUD
    func validateLogin(userName: String,password: String) -> UserProfile{
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

    
    func getUserSleepSession(userId: Int, startDate: NSDate, endDate: NSDate) -> [UserSleepSession]{
        return data.getUserSleepSession(userId, startDate: startDate, endDate: endDate)
    }
    
    // MARK: Hardware Sensors
    func getHistoricalSensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [UserSensorStat]{
        return data.getHistoricalSensorData(userId, startDate: startDate, endDate: endDate)
    }
    
    func saveUserSensorStats(stats: [UserSensorStat]) -> StatusResult {
        return data.saveUserSensorStats(stats)
    }
    
    func getLiveSensorData() -> UserSensorStat{
        return data.getLiveSensorData()
    }
    
    

    // MARK: Tracking
    func startTracking(){
        //1. Confirm Bluetooh Connection & open data streams
        // Open BT Conn
        
        
        //2. Clear Arrays to store data streams
        sensorStatArray.removeAll()
        
        //3. Save data stream to array
        // Test: Fake Data
        for (var i = 0; i < 30000; i++)
        {
            let singleEEGStat = getFakeSensorData(Double(i))
            sensorStatArray.append(singleEEGStat)
        }

        
    }
    
    func endTracking(){
        //1. Ask user if they would like to save session.
        
        //2a. If save then run Algorithm to process and save data to cloud
        // Algo:
        // Save:
        //      business.saveEEGStats(eegStreamArray)
        //      business.saveUserRespiratoryStats(respiratoryStreamArray)
        
        //2b. If not save then delete all session data
        
    }
    
    
    
    // MARK: FAKE Data
    func getFakeSensorData(i: Double)-> UserSensorStat{
        let t = NSTimeInterval(i)
        let eeg = UserSensorStat();
        eeg.RespiratoryValue = Double(arc4random_uniform(256))
        eeg.TimeStamp = NSDate().dateByAddingTimeInterval(t)
        var user = UserProfile()
        user.Id=3
        eeg.User = user
        return eeg
    }
    


}