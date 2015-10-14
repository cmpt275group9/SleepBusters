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
    
    // MARK: Profile
    func validateLogin(userName: String,password: String) -> UserProfile {
        
        let queryString = rootUrl + userprofileController+"/Login?userName="+userName+"&password="+password;
        httpAction.HTTPGet(queryString) {
            (data: String, error: String?) -> Void in
            if error != nil {
                print(error)
                //isValidated = UserProfile();
            } else {
                //isValidated = data.toBool()!;
            }
        }
        return UserProfile();
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
    
    // MARK: Sensor Stats
    
    func saveUserSensorStats(userSleepStats: [UserSensorStat]) -> StatusResult {
        // TODO
        return StatusResult();
    }
    
    func getHistoricalSensorStats(userId: Int, startDate: NSDate, endDate: NSDate) -> [UserSensorStat]{
        // TODO
        return [UserSensorStat]();
    }
    
}