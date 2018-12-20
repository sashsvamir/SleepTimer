//
//  Timer.h
//  SleepTestApp
//
//  Created by sash on 10.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//
//
//
//
//  Управление таймером и событиями
//
//

#import <Foundation/Foundation.h>

#import "ButtonControl.h"
#import "SleepClass.h"
#import "MenuBar.h"


// Variables:
int sleepTime;
int sleepTimeNow;
NSTimer *countDown;

bool statusTimer;
float lastVolume;
float currentVolume;
float newVolume;
float stepVolume;


// Outlets:
@interface Timer : NSObject{

    NSUserDefaults *prefs;

    NSString *string;
    
    IBOutlet ButtonControl *levelIndicator;
    IBOutlet NSTextField* statusLine;
    IBOutlet NSButton* statusButton;
    IBOutlet NSTextField* volumeIndicator;
    IBOutlet NSMenuItem *statusMenu;
    IBOutlet MenuBar *menuBar;

}

// Actions:
- (IBAction)buttonMain:(id)sender;
- (IBAction)buttonLevel:(id)sender;
- (IBAction)menuStart:(id)sender;

// Methods:

- (NSString *)stringAppend:(NSString *)message1 append:(NSString *)message2;

- (void) runTimer;
- (void) stopTimer;
- (void) showTimer;
- (void) initializeVolumeVariables;

-(void)goSleep;
-(void)notifyStopTimer:(NSNotification*)notification;

// Functions:
NSString *currentDate(void);



@end
