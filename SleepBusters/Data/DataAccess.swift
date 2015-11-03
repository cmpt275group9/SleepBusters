//
//  Repository.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-02.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
private let authUserName = "sleep"
private let authPassword = "GC979XOBc7PK#m@It3"
private let userprofileController = "UserProfile"
private let statsController = "Stats"
private var rootUrl = "https://sleepbustersapi.azurewebsites.net/"
private let httpAction = HttpAction()

class DataAccess {
    
    var webApi = WebApiConnector()
    
    init(){
        
    }
    
    // MARK: Web API Connector (TCP/IP)
    
    func validateLogin(userName: String,password: String) ->UserProfile {
        let queryString = rootUrl + userprofileController+"/Login?userName="+userName+"&password="+password;
        let jsonData = httpAction.HTTPGet(queryString);
        print(jsonData.data)
        print("here");
        return UserProfile()
//        httpAction.HTTPGet(queryString) {
//            (data: String, error: String?) -> Void in
//            let userProfile = UserProfile()
//            userProfile.IsValidated = true
//            if error != nil {
//                print(error)
//                callback(userProfile)
//            } else {
//                callback(userProfile)
//            }
//        }
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