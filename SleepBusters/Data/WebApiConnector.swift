//
//  WebApiConnector.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-04.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
class WebApiConnector {

    private let authUserName = "sleep"
    private let authPassword = "GC979XOBc7PK#m@It3"
    private let userprofileController = "UserProfile"
    private let statsController = "Stats"
    private var rootUrl = "https://sleepbustersapi.azurewebsites.net/"
    
    private let httpAction = HttpAction()
    
    func validateLogin(userName: String,password: String) -> Bool {
        var isValidated = false;
        let queryString = rootUrl + userprofileController+"/Login?userName="+userName+"&password="+password;
        httpAction.HTTPGet(queryString) {
            (data: String, error: String?) -> Void in
            if error != nil {
                print(error)
                isValidated = false;
            } else {
                isValidated = data.toBool()!;
            }
        }
        return isValidated;
    }
    
    func registerUserProfile(userParam: NSDictionary) -> UserProfile {
        let queryString = rootUrl + userprofileController+"/Register"
        httpAction.HTTPPost(userParam, url: queryString){
            (data: NSDictionary, error: NSError?) -> Void in
            if error != nil {
                print(error)
                // error
            } else {
                // success
            }

        }
        return UserProfile();
    }
    
    func getUserProfile(userId: Int) -> UserProfile {
        // TODO
        return UserProfile();
    }
    
    func saveUserProfile(userProfile: UserProfile) -> UserProfile {
        // TODO
        return UserProfile();
    }
    
    func getUserRespiratoryStats(startDate: NSDate, endDate: NSDate) -> [RespiratorySensorStat] {
        // TODO
        return [RespiratorySensorStat]();
    }
    
    func saveUserRespiratoryStats(userSleepStats: [RespiratorySensorStat]) -> StatusResult {
        // TODO
        return StatusResult();
    }
    
    func getEEGStats(startDate: NSDate, endDate: NSDate) -> [EEGSensorStat] {
        // TODO
        return [EEGSensorStat]();
    }
    
    func saveEEGStats(stats: [EEGSensorStat]) -> StatusResult {
        // TODO
        return StatusResult();
    }
    
    func getHistoricalRespiratorySensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [RespiratorySensorStat]{
        // TODO
        return [RespiratorySensorStat]();
    }
    
    func getHistoricalEEGSensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [EEGSensorStat]{
        // TODO
        return [EEGSensorStat]();
    }
    
}