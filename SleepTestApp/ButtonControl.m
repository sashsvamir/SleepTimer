//
//  ButtonControl.m
//  SleepTestApp
//
//  Created by sash on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonControl.h"

@implementation ButtonControl



//   Property: int, float, min, max, warning, critical
// ----------------------------------------------------
@synthesize minValue;
@synthesize maxValue;
@synthesize warningValue;
@synthesize criticalValue;
@synthesize settingsFromPlist;

-(int)intValue{ return intValue; }
-(void)setIntValue:(int)value{
    if (intValue != value){
        intValue = value;
        floatValue = value;
        [self changeValue:0];
    }
}

-(float)floatValue{ return floatValue; }
-(void)setFloatValue:(float)value{
    if (floatValue != value) {
        floatValue = value;
        intValue = value;
        [self changeValue:0];
    }
}
// ----------------------------------------------------

@synthesize timerStatus;


-(void)awakeFromNib{
    
    [self setTimerStatus:0];

    levelIndicatorDraw = [[ImageWithMask alloc] init];
    //levelIndicatorBadge = [[ImageWithMask alloc] init];

    
    checkWheel = 0;
    factor = 9;

    [self initVariables];
    [self changeValue:0];
    
}

-(void)initVariables{
    [self setMaxValue:3600];
    [self setMinValue:0];
    [self setWarningValue:[self maxValue]/7];
    [self setCriticalValue:[self maxValue]/11];
    if ( settingsFromPlist == NO ){
        [self setIntValue:[self maxValue]/2];
    }
    if ( settingsFromPlist == YES ){
        
    }
}

- (void)mouseDown:(NSEvent *)theEvent {}

- (void) scrollWheel:(NSEvent *)theEvent{
    [self changeValue:[theEvent deltaY]];
    [self runTimerCheckWheel];
}



-(void)changeValue:(float)value{
    
    float x = [self floatValue] - value*factor;
    
    if ( x > [self minValue] && x < [self maxValue] ) {
        [self setFloatValue:x];
    }
    else {
        if ( x < [self minValue] ) {
            [self setFloatValue:[self minValue]];
        }
        if ( x > [self maxValue] ) {
            [self setFloatValue:[self maxValue]];
        }
    }
    
    [self setLevelIndicatorValue:self];
}





- (void)setLevelIndicatorValue:(id)sender{
    
    float progress = [sender floatValue];
    float pieProgress = progress/[self maxValue];
    
    [levelIndicator setImage:[levelIndicatorDraw progressLevelOfSize:170 withProgress:pieProgress]];
    
    [timeLabel setNewTime:progress];
    
    [menuBar menuBarIconWithProgress:pieProgress withStatus:timerStatus];
    
    //[self setBadgeValue:sender];

}

//
//- (void)setBadgeValue:(id)sender
//{
//    float value = [sender floatValue];
//    
//    if ([self floatValue] < [self warningValue])
//    {
//        if ([self floatValue] < [self criticalValue]) {
//            [levelIndicatorBadge setForegroundColor:[NSColor colorWithDeviceRed:254./255 green:30./255 blue:30./255 alpha:1]];
//        }
//        else
//        {
//            [levelIndicatorBadge setForegroundColor:[NSColor colorWithDeviceRed:253./255 green:150./255 blue:1./255 alpha:1]];
//        }
//    }else{
//        [levelIndicatorBadge setForegroundColor:[NSColor colorWithDeviceRed:110./255 green:160./255 blue:1./255 alpha:1]];
//    }
//    
//    [levelIndicatorBadge badgeApplicationDockIconWithProgress:value/[self maxValue] insetX:2 y:3];
//
//}












-(void)runTimerCheckWheel{
    if (checkWheel == 0){
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationStopTimer" object:nil];
        
        checkWheel = 1;
        
        timerCheckWheelCountDown = [NSTimer scheduledTimerWithTimeInterval:.7
                                            target:self
                                            selector:@selector(stopTimerCheckWheel)
                                            userInfo:nil
                                            repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timerCheckWheelCountDown forMode:NSEventTrackingRunLoopMode];
        //[[NSRunLoop currentRunLoop] addTimer:timerCheckWheelCountDown forMode:NSModalPanelRunLoopMode];
    }
}


-(void)stopTimerCheckWheel{
    checkWheel = 0;
    [timerCheckWheelCountDown invalidate];
    timerCheckWheelCountDown = nil;
    
    NSLog(@"stopTimer and Run Action!");
    
    // Sent Action
    [self sentAction];
    
}

-(void)sentAction{

    if ([self target] != nil && [[self target] respondsToSelector:[self action]])
        [[self target] performSelector:[self action] withObject:self];
    //[self sendAction:[self action] to:[self target]];

}


@end