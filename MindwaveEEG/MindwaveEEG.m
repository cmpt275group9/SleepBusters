/********************************************************
 
 Mindwave.m
 
 Team Name: PillowSoft
 
 Author(s): Klein Gomes
 
 Purpose: Handles all events for the Mindwave EEG including
 dataReceived, didConnect and didDisconnect.
 
 Known Bugs: None
 
 Copyright © 2015 PillowSoft. All rights reserved.
 
 ********************************************************/

#import "MindwaveEEG.h"
#import "TGAccessoryDelegate.h"
#import "TGAccessoryManager.h"

@implementation MindwaveEEG

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

- (void)start
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    TGAccessoryType accessoryType = (TGAccessoryType)[defaults integerForKey:@"accessory_type_preference"];
    BOOL rawEnabled = YES;
    
    if(rawEnabled) {
        // setup the TGAccessoryManager to dispatch dataReceived notifications every 0.05s (20 times per second)
        [[TGAccessoryManager sharedTGAccessoryManager] setupManagerWithInterval:0.05 forAccessoryType:accessoryType];
    } else {
        [[TGAccessoryManager sharedTGAccessoryManager] setupManagerWithInterval:0.2 forAccessoryType:accessoryType];
    }
    
    if([[TGAccessoryManager sharedTGAccessoryManager] accessory] != nil){
        NSLog(@"ThinkGearTouch version: %d", [[TGAccessoryManager sharedTGAccessoryManager]getVersion]);
        [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    }
   
}

- (void)accessoryDidConnect:(EAAccessory *)accessory
{
    // start the data stream to the accessory
    [[TGAccessoryManager sharedTGAccessoryManager] startStream];
    NSLog(@"didConnect");
}

- (void)accessoryDidDisconnect
{
    // Do init here
}

- (void)dataReceived:(NSDictionary *)data
{
     NSLog(@"here");
    NSString * temp = [[NSString alloc] init];
    NSDate * date = [NSDate date];
    
    if([data valueForKey:@"blinkStrength"]){
        blinkStrength = [[data valueForKey:@"blinkStrength"] intValue];    }
    
    if([data valueForKey:@"raw"]) {
        rawValue = [[data valueForKey:@"raw"] shortValue];
    }
    
    if([data valueForKey:@"poorSignal"]) {
        poorSignalValue = [[data valueForKey:@"poorSignal"] intValue];
        temp = [temp stringByAppendingFormat:@"%f: Poor Signal: %d\n", [date timeIntervalSince1970], poorSignalValue];
        //NSLog(@"buffered raw count: %d", buffRawCount);
        buffRawCount = 0;
    }
    
    if([data valueForKey:@"rawCount"]) {
        rawCount = [[data valueForKey:@"rawCount"] intValue];
    }
    
    
    // check to see whether the eSense values are there. if so, we assume that
    // all of the other data (aside from raw) is there. this is not necessarily
    // a safe assumption.
    if([data valueForKey:@"eSenseAttention"]){
        
        eSenseValues.attention =    [[data valueForKey:@"eSenseAttention"] intValue];
        eSenseValues.meditation =   [[data valueForKey:@"eSenseMeditation"] intValue];
        temp = [temp stringByAppendingFormat:@"%f: Attention: %d\n", [date timeIntervalSince1970], eSenseValues.attention];
        temp = [temp stringByAppendingFormat:@"%f: Meditation: %d\n", [date timeIntervalSince1970], eSenseValues.meditation];
        
        eegValues.delta =       [[data valueForKey:@"eegDelta"] intValue];
        eegValues.theta =       [[data valueForKey:@"eegTheta"] intValue];
        eegValues.lowAlpha =    [[data valueForKey:@"eegLowAlpha"] intValue];
        eegValues.highAlpha =   [[data valueForKey:@"eegHighAlpha"] intValue];
        eegValues.lowBeta =     [[data valueForKey:@"eegLowBeta"] intValue];
        eegValues.highBeta =    [[data valueForKey:@"eegHighBeta"] intValue];
        eegValues.lowGamma =    [[data valueForKey:@"eegLowGamma"] intValue];
        eegValues.highGamma =   [[data valueForKey:@"eegHighGamma"] intValue];
        
        
    }
   
}

@end
