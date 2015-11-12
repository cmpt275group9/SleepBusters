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

@interface MindwaveEEG : NSObject <TGAccessoryDelegate>

- (void)start;
- (void)accessoryDidConnect:(EAAccessory *)accessory;
- (void)accessoryDidDisconnect;
- (void)dataReceived:(NSDictionary *)data;

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


@end
