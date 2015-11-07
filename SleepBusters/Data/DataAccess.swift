/********************************************************
 
 DataAccess.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes
 
 Purpose:  The DataAccess class serves as a repository and
 I/O for SleepBusters. The Business layer will have to 
 invoke the DataAccess class inorder to receive Live sensor
 data or save/retreive data from the database.
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation

private let authUserName = "sleep"
private let authPassword = "GC979XOBc7PK#m@It3"
private let userprofileController = "UserProfile"
private let statsController = "Stats"
private var rootUrl = "https://sleepbustersapi.azurewebsites.net/"
private let httpAction = HttpAction()

class DataAccess {
    
    init(){
        
    }
    
    // MARK: Web API (TCP/IP)
    
    func validateLogin(userName: String,password: String) ->UserProfile {
        let queryString = rootUrl + userprofileController+"/Login?userName="+userName+"&password="+password;
        let jsonData = httpAction.HTTPGet(queryString);
        print(jsonData.data)
        return UserProfile()
    }
    
    func getUserSleepSessions(userId: Int, startDate: NSDate, endDate: NSDate) -> [UserSleepSession]{
        var userSleepSessions = [UserSleepSession()]
        let userPro = UserProfile()
        userPro.Id = 1
        for var index = 0; index < 7; index++
        {
            let userSleep = UserSleepSession()
            
            userSleep.User = userPro;
            
            
            userSleep.TotalLightSleepHours = Double(Int(arc4random_uniform(5)));
            userSleep.TotalAwakeHours = Double(Int(arc4random_uniform(5)));
            userSleep.TotalDeepSleepHours = Double(Int(arc4random_uniform(11)));
            let totalHours = userSleep.TotalLightSleepHours! + userSleep.TotalAwakeHours! + userSleep.TotalDeepSleepHours!
            userSleep.TotalHoursAsleep = Double(totalHours)
            userSleepSessions.append(userSleep)
        }
        return userSleepSessions
    }
    
    func getLastNSleepSessions(userId: Int, n: Int) -> [UserSleepSession]{
        var userSleepSessions = [UserSleepSession()]
        let userPro = UserProfile()
        userPro.Id = userId;
        for var index = 0; index < n; index++
        {
            let userSleep = UserSleepSession()
            userSleep.User = userPro;
            userSleep.TotalLightSleepHours = Double(Int(arc4random_uniform(5)));
            userSleep.TotalAwakeHours = Double(Int(arc4random_uniform(5)));
            userSleep.TotalDeepSleepHours = Double(Int(arc4random_uniform(11)));
            let totalHours = userSleep.TotalLightSleepHours! + userSleep.TotalAwakeHours! + userSleep.TotalDeepSleepHours!
            userSleep.TotalHoursAsleep = Double(totalHours)
            userSleepSessions.append(userSleep)
        }
        return userSleepSessions
    }
    
    func saveUserSleepSession(userSleepSession: UserSleepSession) ->  Bool
    {

        let queryString = rootUrl + userprofileController+"/SaveUserSleepSession"
        httpAction.HTTPPost(NSDictionary(), url: queryString){
            (data: NSDictionary, error: NSError?) -> Void in
            if error != nil {
                print(error)
              //  return false;
            } else {
              //  return true;
            }
            
        }
        return true;
    }

    func registerUserProfile(user: UserProfile) -> UserProfile {
        let queryString = rootUrl + userprofileController+"/Register"
        httpAction.HTTPPost(NSDictionary(), url: queryString){
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
        return UserProfile()
    }
    
    func saveUserProfile(userProfile: UserProfile) -> UserProfile {
        return UserProfile()
    }
    
    // MARK: Hardware Sensors (Bluetooth)
    
    // TODO
    // Implement this
    func getHistoricalSensorData(userId: Int, startDate: NSDate, endDate: NSDate) -> [UserSensorStat]{
        return [UserSensorStat]()
    }
    
    // TODO
    // Implement this
    func saveUserSensorStats(stats: [UserSensorStat]) -> StatusResult {
        return StatusResult()
    }

    // TODO
    // Implement this
    func getLiveSensorData() -> UserSensorStat{
        return UserSensorStat()
    }
}