/********************************************************
 
 SleepBustersRespiratorySensor.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This class represents the SleepBusters Repiratory
 Sensor. It will create an instance for each set of data
 that is received from the repiratory sensor.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
class SleepBustersRespiratorySensor
{
    var value: Double? = nil
    var sleepPositionX: Double? = nil
    var sleepPositionY: Double? = nil
    var sleepPositionZ: Double? = nil
    var ambientTemp: Double? = nil
    var timeStamp: NSDate? = nil
}