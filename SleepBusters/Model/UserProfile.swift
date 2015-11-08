/********************************************************
 
 UserProfile.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This model class represents a single user profile.
 It will be used to save and delete user profile information.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
class UserProfile : Serializable {
    var Id: Int = 0
    var UserName: String = ""
    var Password: String = ""
    var FirstName: String = ""
    var LastName: String = ""
    var DateOfBirth: NSDate? = nil
    var Height: Double? = nil
    var Weight: Double? = nil
    var Gender: String = ""
    var Occupation: String = ""
    var DoesSnore: Bool? = nil
    var DoesDrinkCoffee: Bool? = nil
    var DoesDrinkAlcohol: Bool? = nil
    var IsValidated:Bool = false
    
    override init() {
    
    }
}

