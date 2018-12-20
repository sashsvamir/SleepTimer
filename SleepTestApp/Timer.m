//
//  Timer.m
//  SleepTestApp
//
//  Created by sash on 10.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Timer.h"
#import "NKVolumeControl.h"

@implementation Timer



- (void)awakeFromNib {

    // initialize user preferences:
    prefs = [NSUserDefaults standardUserDefaults];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(notifyStopTimer:)
                                          name:@"notificationStopTimer"
                                          object:nil];
    
    statusTimer = 0;
    [levelIndicator initVariables];
    
    
    string = [prefs stringForKey:@"LastSetElapsedTime"];
    if (string) {
        [levelIndicator setIntValue:[string intValue]];
        [levelIndicator setSettingsFromPlist:YES];
    } else {
        [levelIndicator setIntValue:[levelIndicator maxValue]/2];
    }

    sleepTimeNow = [levelIndicator intValue];
    
    
    string = [prefs stringForKey:@"LastSleepSystem"];
    if (string){
        [statusLine setStringValue:[self stringAppend:@"Last sleep at " append:string]];
    } else {
        [statusLine setStringValue:@""];
    }

    [self initializeVolumeVariables];
    
    // Button Start/Pause prepeare images:
    [[statusButton cell] setHighlightsBy:NSContentsCellMask];
    [[statusButton cell] setAlternateImage:[NSImage imageNamed:@"IB-button-top-off.png"]];
    
    
    return;
}






// Recieved Notyfication Stop Timer

-(void)notifyStopTimer:(NSNotification*)notification {
    NSLog(@"SleepTimer Stop! (recieved notifycation)");
    [self stopTimer];
}







// Actions:

- (IBAction)menuStart:(id)sender{
    [self buttonMain:sender];
}


- (IBAction)buttonLevel:(id)sender{

    //NSLog(@"Timer.h: -(void)buttonLevel:(id)sender");
    
    sleepTime = [levelIndicator intValue];
    
    if (sleepTime < [levelIndicator maxValue]/20)
    {
        sleepTime = [levelIndicator maxValue]/20;
        [levelIndicator setIntValue:sleepTime];
        [levelIndicator changeValue:0];
    }
    
    sleepTimeNow = sleepTime;
    
    [prefs setObject:[NSString stringWithFormat:@"%d", sleepTime] forKey:@"LastSetElapsedTime"];
    //NSLog(@"Value Level Indicator is: %d", sleepTime);
    
    if (statusTimer == 1){
        [self stopTimer];
    }
    [self runTimer];

}






- (void)buttonMain:(id)sender{
    
    if (statusTimer == 0)
    {
        sleepTimeNow = [levelIndicator intValue];
        sleepTime = sleepTimeNow;
        
        [self runTimer];
    }
    else
    {
        [self stopTimer];
    }
    
}








// Methods:




- (void)runTimer {
    countDown = [NSTimer scheduledTimerWithTimeInterval:1
                         target:self
                         selector:@selector(showTimer)
                         userInfo:nil
                         repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:countDown forMode:NSEventTrackingRunLoopMode];
    //[[NSRunLoop currentRunLoop] addTimer:countDown forMode:NSModalPanelRunLoopMode];

    statusTimer = 1;
    [levelIndicator setTimerStatus:statusTimer];

    // Button Start/Pause change image:
    [statusButton setImage:[NSImage imageNamed:@"IB-button-top-off.png"]];
    
    [statusMenu setTitle:@"Stop"];
    [menuBar menuBarIconStatus:statusTimer];
    
    [self initializeVolumeVariables];
    
    NSLog(@"SleepTimer Start!");
    
}





- (void)stopTimer{
    [countDown invalidate];
    countDown = nil;
    
    statusTimer = 0;
    [levelIndicator setTimerStatus:statusTimer];
    
    // Button Start/Pause change image:
    [statusButton setImage:[NSImage imageNamed:@"IB-button-top-on.png"]];
    
    [statusMenu setTitle:@"Start"];
    [menuBar menuBarIconStatus:statusTimer];
    
    NSLog(@"SleepTimer Stop!");

    // Return Volume Value
    [NKVolumeControl setVolume:lastVolume];

};



- (void)showTimer {

    if ( (int)([NKVolumeControl getVolume]*100) != (int)(currentVolume*100) ) {
        [self initializeVolumeVariables];
    }
    
    newVolume = newVolume - stepVolume;
    
    if ( (int)(newVolume*100) != (int)(currentVolume*100) & newVolume > 0.02 & newVolume > stepVolume )
    {
        [NKVolumeControl setVolume:newVolume];
        [volumeIndicator setFloatValue:newVolume];
        currentVolume = [NKVolumeControl getVolume];
    }

    
    sleepTimeNow--;
    
    [levelIndicator setIntValue:sleepTimeNow];

    if (sleepTimeNow == 60)
    {
        [self growlNotification:@"After 1 min Mac going to sleep..." withTitle:@"Sleep Timer"];
    }
    if (sleepTimeNow < 1)
    {
        [self goSleep];
    }
    
}








- (void)goSleep {

    [self stopTimer];
    
    [prefs setObject:currentDate() forKey:@"LastSleepSystem"];

    // go system to sleep:
    SleepClass *goSleep = [[SleepClass alloc] init];
    [goSleep goSleep];
    [goSleep release];

    // after sleep make interface elements to defaults:
    [levelIndicator setIntValue:sleepTime];    
    [statusLine setStringValue:[self stringAppend:@"Last sleep at " append:currentDate()]];

}


-(void)growlNotification:(NSString *)message withTitle:(NSString *)title{
    
    GrowlNotifycation *growlTest = [[GrowlNotifycation alloc] init];
    [growlTest notifycation:message title:title];
    [growlTest release];
    
}



- (void)initializeVolumeVariables {

    // чем меньше stepVolume тем тем меньше уменьшается громкость
    // чем больше дробная часть / ( sleepTime + (sleepTime/5) ) тем меньше уменьшается громкость
    // чем меньше (sleepTime/10)=000096 (sleepTime/5)=000086 (sleepTime/2)=000069
    
    lastVolume = [NKVolumeControl getVolume];
    currentVolume = lastVolume;
    stepVolume = ( lastVolume / ( sleepTime + (sleepTime/2) ) );
    NSLog(@"step volume: %f", stepVolume);
    newVolume = currentVolume;

}








// Functions:

NSString *currentDate(void){
    
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = [NSDate date];

    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *message = [formatter stringFromDate:date];
    
    return message;
}



- (NSString *)stringAppend:(NSString *)message1 append:(NSString *)message2{
    message1 = [message1 stringByAppendingString:message2];
    return message1;
}




@end
