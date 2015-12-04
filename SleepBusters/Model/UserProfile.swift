/********************************************************
 
 UserProfile.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This model class represents a single user profile.
 It will be used to save and delete user profile information.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation


final class UserProfile: ResponseObjectSerializable, ResponseCollectionSerializable {
    var id: Int? = nil
    var userName: String? = nil
    var password: String? = nil
    var firstName: String? = nil
    var lastName: String? = nil
    var isValidated:Bool? = nil
    
    var dateOfBirth: NSDate? = nil
    var height: Double? = nil
    var weight: Double? = nil
    var gender: Int?  = nil
    
    var occupation: String?  = nil

    var conditions: [String]? = nil
    
    
    // Survey Questions
    var questions = [Int: [Int]]()
    

    init(){
        
    }
    
    init?(response: NSHTTPURLResponse, representation: AnyObject) {
        self.id = representation.valueForKeyPath("Id") as? Int
        self.userName =  representation.valueForKeyPath("UserName") as? String
        self.password = nil
        self.firstName = representation.valueForKeyPath("FirstName") as? String
        self.lastName = representation.valueForKeyPath("LastName") as? String
        self.isValidated = representation.valueForKeyPath("IsValidated") as? Bool
        self.dateOfBirth = representation.valueForKeyPath("DateOfBirth") as? NSDate
        

        self.height = representation.valueForKeyPath("Height") as? Double
        self.weight = representation.valueForKeyPath("Weight") as? Double
        self.gender = representation.valueForKeyPath("Gender") as? Int
        self.occupation = representation.valueForKeyPath("Occupation") as? String


    }
    
    static func collection(response response: NSHTTPURLResponse, representation: AnyObject) -> [UserProfile] {
        var users: [UserProfile] = []
        
        if let representation = representation as? [[String: AnyObject]] {
            for userRepresentation in representation {
                if let user = UserProfile(response: response, representation: userRepresentation) {
                    users.append(user)
                }
            }
        }
        
        return users
    }
}

