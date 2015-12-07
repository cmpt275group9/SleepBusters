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
import Alamofire

private let authUserName = "sleep"
private let authPassword = "GC979XOBc7PK#m@It3"
private let userprofileController = "UserProfile"
private let statsController = "Stats"
private var rootUrl = "https://sleepbustersapi.azurewebsites.net/"
private let httpAction = HttpAction()
let defaults = NSUserDefaults.standardUserDefaults()

class DataAccess {
    
    init(){
        
    }
    
    // MARK: Web API (TCP/IP)
    
    /**
    Creates a request to the WebApi for authenticating a user name and password and returns
    user profile with UserProfile.IsValidated set to true.
    - parameter UserName: The user's login name.
    - parameter Password: The user's password.
    :returns: a User Profile
    */
    func login(userName: String,password: String,callback: (UserProfile, NSError?) -> Void) -> Void {
        let queryString = rootUrl + userprofileController+"/Login?userName="+userName+"&password="+password
        let parameters = [
            "userName": userName,
            "password": password
        ]
        
        Alamofire
            .request(.POST, queryString, parameters: parameters, encoding: .JSON)
            .responseObject { (response: Response<UserProfile, NSError>) in
                //debugPrint(response)
                callback(response.result.value!,response.result.error)
            }
    }
    
    /**
     Creates a request to the WebApi to get a collection of User Sleep Session from the database
     - parameter UserId: The user's ID
     - parameter startDate: The start date of the sleep session.
     - parameter endDate: The end date of the sleep session.
     :returns: Array of Sleep Sessions
     */
    func getUserSleepSessions(userId: Int, startDate: NSDate, endDate: NSDate) -> [UserSleepSession]{
        var userSleepSessions = [UserSleepSession()]
        let userPro = UserProfile()
        userPro.id = 1
        for var index = 0; index < 7; index++
        {
            let userSleep = UserSleepSession()
            
//            userSleep.User = userPro
//            userSleep.TotalLightSleepHours = Double(Int(arc4random_uniform(5)))
//            userSleep.TotalAwakeHours = Double(Int(arc4random_uniform(5)))
//            userSleep.TotalDeepSleepHours = Double(Int(arc4random_uniform(11)))
           // let totalHours = userSleep.TotalLightSleepHours! + userSleep.TotalAwakeHours! + userSleep.TotalDeepSleepHours!
     //       userSleep.TotalHoursAsleep = Double(totalHours)
            userSleepSessions.append(userSleep)
        }
        return userSleepSessions
    }
    
    /**
     Creates a request to the WebApi to get a collection of User Sleep Session from the database.
     - parameter UserId: The user's ID
     - parameter n: The user's last N user sessions from the database.
     :returns: Array of N Sleep Sessions
     */
    func getLastNSleepSessions(userId: Int, n: Int,callback: ([UserSleepSession], NSError?) -> Void) -> Void {
        
        let queryString = rootUrl + userprofileController
        let fullQuery = queryString + "/GetLastNUserSessions?userId="+String(defaults.integerForKey("userId"))+"&n="+String(n)

        let parameters = [
            "userId": defaults.integerForKey("userId"),
            "n": n
        ]
        
        Alamofire
            .request(.POST, fullQuery, parameters: parameters, encoding: .JSON)
            .responseCollection { (response: Response<[UserSleepSession], NSError>) in
                callback(response.result.value!,response.result.error)
            }
        
    }
    
    /**
     Creates a request to the WebApi to get a single User Sleep Session from the database.
     - parameter UserId: The user's ID
     - parameter Date: The user sleep session date
     :returns: a UserSleepSession object
     */
    func getUserSleepSessionForDate(date: String,callback: (UserSleepSession, NSError?) -> Void) -> Void {
        
        let queryString = rootUrl + userprofileController
        let fullQuery = queryString + "/getUserSleepSessionForDate?userId="+String(defaults.integerForKey("userId"))+"&date="+date
        
        let parameters = [
            "userId": defaults.integerForKey("userId"),
            "date":  date
        ]
        Alamofire
            .request(.POST, fullQuery, parameters: parameters as! [String : AnyObject], encoding: .JSON)
            .responseObject { (response: Response<UserSleepSession, NSError>) in
                callback(response.result.value!,response.result.error)
        }
        
    }
    
    /**
     Creates a request to the WebApi to save/update a User Sleep Stats to the database.
     - parameter UserSleepStat: The User Profile to update. (Update User Sleep stat)
     :returns:  Void
     */
    func saveSleepStat(userSensorStat: UserSensorStat){
        let queryString = rootUrl + userprofileController
        var fullQuery = queryString + "/SaveSleepStat?ID=-1"
        
        let parameters = [
            "ID": -1,
            "UserProfileId": defaults.integerForKey("userId"),
            "EegDelta": userSensorStat.EegDelta == nil ? -1 : userSensorStat.EegDelta!,
            "EegTheta": userSensorStat.EegTheta == nil ? -1 : userSensorStat.EegTheta!,
            "EegLowAlpha": userSensorStat.EegLowAlpha == nil ? -1 : userSensorStat.EegLowAlpha!,
            "EegHighAlpha": userSensorStat.EegHighAlpha == nil ? -1 : userSensorStat.EegHighAlpha!,
            "EegLowBeta": userSensorStat.EegLowBeta == nil ? -1 : userSensorStat.EegLowBeta!,
            "EegHighBeta":userSensorStat.EegHighBeta == nil ? -1 : userSensorStat.EegHighBeta!,
            "EegLowGamma":userSensorStat.EegLowGamma == nil ? -1 : userSensorStat.EegLowGamma!,
            "EegHighGamma":userSensorStat.EegHighGamma == nil ? -1 : userSensorStat.EegHighGamma!,
            "DataQuality":userSensorStat.DataQuality == nil ? -1 : userSensorStat.DataQuality!
        ]
        
        Alamofire
            .request(.POST, fullQuery, parameters: parameters as! [String : Int] , encoding: .JSON)
            .responseObject { (response: Response<UserProfile, NSError>) in
                debugPrint(response)
                //callback(response.result.value!,response.result.error)
        }
    }
    
    
    /**
     Creates a request to the WebApi to save/update a User Sleep Session to the database.
     - parameter UserSleepSession: The User Profile to update. (Update User Sleep Session)
     :returns: Is Success
     */
    func saveUserSleepSession(userSleepSession: UserSleepSession) ->  Void
    {
        let queryString = rootUrl + userprofileController
        var fullQuery = queryString + "/SaveUserSleepSession?Id=-1"
        
        let date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        
        let date1 = dateFormatter.stringFromDate(userSleepSession.startSessionDate!)
        let date2 = dateFormatter.stringFromDate(userSleepSession.endSessionDate!)
        
        let parameters = [
            "Id": -1,
            "UserProfileId": userSleepSession.userId!,
            "startSessionDate": date1,
            "endSessionDate": date2,
            "TotalHoursAsleep": userSleepSession.totalHoursAsleep!,
            "TotalDeepSleepHours": userSleepSession.totalDeepSleepHours!,
            "TotalAwakeHours": userSleepSession.totalAwakeHours!,
            "TotalLightSleepHours": userSleepSession.totalLightSleepHours!,
            "AverageTemp": userSleepSession.averageTemp!,
            "AverageHumidity": userSleepSession.averageHumidity!,
            "Bpm": userSleepSession.bpm!,
            "TimesApneaDetected": userSleepSession.timesApneaDetected!,
            "CoffeeIsOn" : userSleepSession.coffeeIsOn!,
            "HomeIsOn" : userSleepSession.homeIsOn!,
            "BeerIsOn" : userSleepSession.beerIsOn!,
            "ExerciseIsOn": userSleepSession.exerciseIsOn!,
            "FaceNumber": userSleepSession.faceNumber!
        ]

        
        Alamofire
            .request(.POST, fullQuery, parameters: parameters as! [String : NSObject] , encoding: .JSON)
            .responseObject { (response: Response<UserProfile, NSError>) in
                debugPrint(response)
                //callback(response.result.value!,response.result.error)
        }
    }

    /**
     Creates a request to the WebApi to Register a new User Account.
     - parameter UserProfile: The User Profile to register. (Create account)
     :returns: a User Profile
     */
    func registerUserProfile(userProfile: UserProfile,callback: (UserProfile, NSError?) -> Void) {
        
        let queryString = rootUrl + userprofileController
        var gender: String
        if (userProfile.gender! == 0){
            gender = "M"
        }else if (userProfile.gender! == 1){
            gender = "F"
        }else{
            gender = "O"
        }
        var fullQuery = queryString + "/Register?Id=-1"
            fullQuery += "&UserName=" + userProfile.userName!

        let date = NSDate()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        
        let date1 = dateFormatter.stringFromDate(userProfile.dateOfBirth!)
        
        let parameters = [
            "Id": -1,
            "UserName": userProfile.userName!,
            "FirstName": userProfile.firstName!,
            "LastName": userProfile.lastName!,
            "Occupation": userProfile.occupation!,
            "DateOfBirth": date1,
            "Weight": userProfile.weight!,
            "Height": userProfile.height!,
            "Gender": gender,
            "Password": userProfile.password!
        ]
        
        
        Alamofire
            .request(.POST, fullQuery, parameters: parameters as! [String : AnyObject] , encoding: .JSON)
            .responseObject { (response: Response<UserProfile, NSError>) in
                debugPrint(response)
                callback(response.result.value!,response.result.error)
        }
    }
    
    /**
     Creates a request to the WebApi to retrieve a User Profile from the database.
     - parameter UserId: The user's ID
     :returns: a User Profile
     */
    func getUserProfile(callback: (UserProfile, NSError?) -> Void) {
        let queryString = rootUrl + userprofileController
        let fullQuery = queryString + "/GetUserProfile?userId="+String(defaults.integerForKey("userId"))
        
        let parameters = [
            "userId": defaults.integerForKey("userId")
        ]

        Alamofire
            .request(.POST, fullQuery, parameters: parameters, encoding: .JSON)
            .responseObject { (response: Response<UserProfile, NSError>) in
                debugPrint(response)
                callback(response.result.value!,response.result.error)
        }
    }
    
    /**
     Creates a request to the WebApi to save/update a User Profile to the database.
     - parameter UserProfile: The User Profile to update. (Update account)
     :returns: The user profile that was just saved
     */
    func saveUserProfile(userProfile: UserProfile,callback: (UserProfile, NSError?) -> Void) {
        let queryString = rootUrl + userprofileController
        let fullQuery = queryString + "/SaveUserProfile" //?userId="+String(userId)+"&n="+String(n)
        
        let parameters = [
            "Id": 3,
            "FirstName": userProfile.firstName!,
            "LastName": userProfile.lastName!,
            "Weight": userProfile.weight!,
            "Height": userProfile.height!,
            "Gender": userProfile.gender! == 0 ? "M" : "F"
        ]

        
        Alamofire
            .request(.POST, fullQuery, parameters: (parameters as! [String : AnyObject]), encoding: .JSON)
            .responseObject { (response: Response<UserProfile, NSError>) in
                //debugPrint(response)
                callback(response.result.value!,response.result.error)
        }
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


/**
Alamofire Request Extension Methods
 */

public protocol ResponseObjectSerializable {
    init?(response: NSHTTPURLResponse, representation: AnyObject)
}

public protocol ResponseCollectionSerializable {
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [Self]
}

extension Alamofire.Request {
    public func responseCollection<T: ResponseCollectionSerializable>(completionHandler: Response<[T], NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<[T], NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let response = response {
                    return .Success(T.collection(response: response, representation: value))
                } else {
                    let failureReason = "Response collection could not be serialized due to nil response"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

extension Request {
    public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
        let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
            guard error == nil else { return .Failure(error!) }
            
            let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
            let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
            
            switch result {
            case .Success(let value):
                if let
                    response = response,
                    responseObject = T(response: response, representation: value)
                {
                    return .Success(responseObject)
                } else {
                    let failureReason = "JSON could not be serialized into response object: \(value)"
                    let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
                    return .Failure(error)
                }
            case .Failure(let error):
                return .Failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}






