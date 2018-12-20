//
//  AppDelegate.m
//  SleepTestApp
//
//  Created by sash on 09.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "SleepClass.h"


@implementation AppDelegate

//@synthesize window = _window;


- (void)dealloc
{
    [super dealloc];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    // Checking Sleep Mode Support:
    SleepClass *checkSleepClass = [[SleepClass alloc] init];
    [checkSleepClass checkSupportSleepMode];
    [checkSleepClass release];

    
    
    // Checking DisplaySleep status:
    //
    //#import "ApplicationServices/ApplicationServices.h"
    //
    //bool x = CGDisplayIsAsleep (CGMainDisplayID());
    //NSLog(@"Display sleep: %d",(int)x);




    
    
    
    /*проверка наличия метода showTimer в классе Timer
     Timer *myTimer = [[Timer alloc] init];
     if ([myTimer respondsToSelector: @selector(showTimer)]) {
     NSLog(@"Выполняем метод showActivity в класса myTimer образованного от класса Timer!\n");
     [myTimer showTimer];
     }*/
    
    //[GrowlNotifycation notify];

}


@end