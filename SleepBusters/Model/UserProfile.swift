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
    var userName: String = ""
    var password: String = ""
    var FirstName: String = ""
    var DateOfBirth: String = "2001-01-01"
    var Height: Double = 0
    var Weight: Double = 0
    var Gender: String = ""
    var Occupation: String = ""
    var DoesSnore: Bool = false
    var DoesDrinkCoffee: Bool = false
    var DoesDrinkAlcohol: Bool = false
//  var PreexistingConditions = [String]()
    
    override init() {
    
    }
}

