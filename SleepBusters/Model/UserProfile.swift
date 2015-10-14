//
//  UserProfile.swift
//  SleepBusters
//
//  Created by Klein on 2015-10-02.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

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

