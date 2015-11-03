//
//  UserInterfaceHelpers.swift
//  SleepBusters
//
//  Created by Klein on 2015-11-03.
//  Copyright © 2015 PillowSoft. All rights reserved.
//

import Foundation
import UIKit

class UserInterfaceHelpers {
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
