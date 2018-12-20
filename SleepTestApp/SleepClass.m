//
//  SleepClass.m
//  SleepTestApp
//
//  Created by sash on 20.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SleepClass.h"

@implementation SleepClass


-(BOOL)checkSupportSleepMode{

    // Checking system for support Sleep mode:
    // Need Frameworks: IOKit
    //
    
    bool x = IOPMSleepEnabled();
    if (x == 1) {
        NSLog(@"System support sleep mode, ok.");
        return YES;
    } else{
        NSLog(@"System NOT support sleep mode, IOPMSleepEnabled() return: %d",(int)x);
        NSRunAlertPanel(@"Warning", @"Application detected your Mac is not support Sleep mode. May be it's wrong and SleepTimer was continue steel working...", @"Ok", nil, nil);
        return NO;
    }

}



-(void)goSleep{
    

    // Switch Sleep mode:
    // Need Frameworks: IOKit
    // #include <IOKit/pwr_mgt/IOPMLib.h>


    // Initiate "port"
    io_connect_t port = IOPMFindPowerManagement(MACH_PORT_NULL);


    // Request Sleep
    IOReturn requestSystemInitiateSleep = IOPMSleepSystem(port);


    if (requestSystemInitiateSleep == kIOReturnSuccess)
    {
        NSLog(@"Mac is going to sleep!\n");
    }
    else
    {
        NSLog(@"Mac wouldn't sleep!\n");
    }
}

@end
