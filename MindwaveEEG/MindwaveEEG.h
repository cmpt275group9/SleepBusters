/********************************************************
 
 Mindwave.h
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes
 
 Purpose:  Header file for the Mindwave EEG
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

#import <ExternalAccessory/ExternalAccessory.h>
#import <Foundation/Foundation.h>
#import "TGAccessoryDelegate.h"
#import "TGAccessoryManager.h"


// the EEG power bands
typedef struct {
    int delta;
    int theta;
    int lowAlpha;
    int highAlpha;
    int lowBeta;
    int highBeta;
    int lowGamma;
    int highGamma;
} EEGValues;


// the eSense values
typedef struct {
    int attention;
    int meditation;
} ESenseValues;

@interface MindwaveEEG : UIViewController <TGAccessoryDelegate> {
    short rawValue;
    int rawCount;
    int buffRawCount;
    int blinkStrength;
    int poorSignalValue;
    int heartRate;
    float respiration;
    int heartRateAverage;
    int heartRateAcceleration;
    
    ESenseValues eSenseValues;
    EEGValues eegValues;
    
    bool logEnabled;
    NSFileHandle * logFile;
    NSString * output;
    
    UIView * loadingScreen;
    
    NSThread * updateThread;
}

- (void)start;
- (void)accessoryDidConnect:(EAAccessory *)accessory;
- (void)accessoryDidDisconnect;
- (void)dataReceived:(NSDictionary *)data;


@end
