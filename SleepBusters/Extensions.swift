/********************************************************
 
 Extensions.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes
 
 Purpose:  Helper methods for datatypes.
 
 Copyright © 2015 PillowSoft. All rights reserved. 
 
 ********************************************************/

import Foundation

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
}

extension Dictionary {
    mutating func map(transform: (key:Key, value:Value) -> (Value)) {
        for key in self.keys {
            var newValue = transform(key: key, value: self[key]!)
            self.updateValue(newValue, forKey: key)
        }
    }
}

