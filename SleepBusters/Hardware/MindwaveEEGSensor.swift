/********************************************************
 
 MindwaveEEGSensor.swift
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes, Conrad Yeung
 
 Purpose:  This class represents the default Mindwave Mobile 
 properties. Each instance of this class will contain a
 received set of the from the Mindwave EEG Sensor.
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

import Foundation
class MindwaveEEGSensor
{
    var raw: Int? = nil
    var bufferedRaw: Int? = nil
    var signalQuality: Int? = nil
    var blinkStrength: Int? = nil

    var eSenseMeditation: Int? = nil
    var eSenseAttention: Int? = nil
    
    var eegDelta: Int? = nil
    var eegTheta: Int? = nil
    
    var eegLowAlpha: Int? = nil
    var eegHighAlpha: Int? = nil
    
    var eegLowBeta: Int? = nil
    var eegHighBeta: Int? = nil
    
    var eegLowGamma: Int? = nil
    var eegHighGamma: Int? = nil
}

// FROM API

//• eSenseAttention — e eSenseTM Attention level
//• eSenseMeditation — e eSense Meditation level
//• blinkStrength — e value reporting the strength of the user's most recent blink
//• raw — e raw, unprocessed signal coming from the headset
//• bufferedRaw — e raw data buffered in an NSArray since the last dataReceived: call
//• eegDelta — e delta EEG power band
//• eegTheta — e theta EEG power band
//• eegLowAlpha — e low-alpha EEG power band
//• eegHighAlpha — e high-alpha EEG power band
//• eegLowBeta — e low-beta EEG power band
//• eegHighBeta — e high-beta EEG power band
//• eegLowGamma — e low-gamma EEG power band
//• eegHighGamma — e high-gamma EEG power band

//  There is no guarantee that any speci􏲷c key-value pair will exist in the NSDictionary passed by the noti􏲷cation. Strictly speaking, you should check for nil values returned by every valueForKey: call. In practice, you can make the assumption that raw will be returned on every noti􏲷cation, and that if any one of the other keys exist in the data returned, then the complete set of key-value pairs will exist.