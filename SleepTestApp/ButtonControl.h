//
//  ButtonControl.h
//  SleepTestApp
//
//  Created by sash on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//#import <AppKit/AppKit.h>
//
//
//
//
//  Управлением графикой приложения
//
//
//

#import "ImageWithMask.h"
#import "TimeLabel.h"
#import "MenuBar.h"

@interface ButtonControl : NSButton{
    
    // Property: int, float, min, max, warning, critical
    // ----------------------------------------------------
    int   intValue;
    float floatValue;
    float maxValue;
    float minValue;
    float warningValue;
    float criticalValue;
    // ----------------------------------------------------
    
    BOOL timerStatus;
    
    int factor; // Speed of Mouse Scroll Wheel
    
    BOOL settingsFromPlist;
    BOOL checkWheel;
    NSTimer *timerCheckWheelCountDown;

    NSTrackingArea *trackingArea;
    
    IBOutlet TimeLabel *timeLabel;
    IBOutlet MenuBar *menuBar;
    
    ImageWithMask *levelIndicatorDraw;
    IBOutlet id levelIndicator;

    //ImageWithMask *levelIndicatorBadge;

}


//   Property: int, float, min, max, warning, critical
// ----------------------------------------------------
-(int)intValue;
-(void)setIntValue:(int)value;
-(float)floatValue;
-(void)setFloatValue:(float)value;
@property (readwrite) float maxValue;
@property (readwrite) float minValue;
@property (readwrite) float criticalValue;
@property (readwrite) float warningValue;
@property (readwrite) BOOL settingsFromPlist;
// ----------------------------------------------------

@property (readwrite) BOOL timerStatus;

-(void)initVariables;

-(void)changeValue:(float)value;

-(void)setLevelIndicatorValue:(id)sender;
//-(void)setBadgeValue:(id)sender;

-(void)runTimerCheckWheel;
-(void)stopTimerCheckWheel;

-(void)sentAction;



@end
