/********************************************************
 
 UserSleepSession.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This model class represents the UserSleepSession
 table in the database. It will be used to save and display
 user sleep session slee data.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation

final class UserSleepSession: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    var id: Int? = nil
    var userId: Int? = nil
    var startSessionDate: NSDate? = nil
    var endSessionDate:NSDate? = nil
    var totalHoursAsleep: Double? = nil
    var totalDeepSleepHours: Double? = nil
    var totalAwakeHours: Double? = nil
    var totalLightSleepHours: Double? = nil
    
    var timesApneaDetected: Int? = nil
    var bpm: Int? = nil
    var averageTemp: Double? = nil
    var averageHumidity: Double? = nil
    
    init(){
        
    }
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = (representation.valueForKeyPath("ID") as? Int)!
        self.userId = (representation.valueForKeyPath("UserProfileId") as? Int)!
        self.startSessionDate = representation.valueForKeyPath("StartSessionDate") as? NSDate
        self.endSessionDate = representation.valueForKeyPath("EndSessionDate") as? NSDate
        self.totalHoursAsleep = representation.valueForKeyPath("TotalHoursAsleep") as? Double
        self.totalDeepSleepHours = representation.valueForKeyPath("TotalDeepSleepHours") as? Double
        self.totalAwakeHours = representation.valueForKeyPath("TotalAwakeHours") as? Double
        self.totalLightSleepHours = representation.valueForKeyPath("TotalLightSleepHours") as? Double
        
        self.bpm = representation.valueForKeyPath("Bpm") as? Int
        self.timesApneaDetected = representation.valueForKeyPath("TimesApneaDetected") as? Int
        self.averageTemp = representation.valueForKeyPath("AverageTemp") as? Double
        self.averageHumidity = representation.valueForKeyPath("AverageHumidity") as? Double
    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [UserSleepSession] {
        var users: [UserSleepSession] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let user = UserSleepSession(response: response, representation: userRepresentation) {
                    users.append(user)
                }
            }
        }
        
        return users
    }
    
}