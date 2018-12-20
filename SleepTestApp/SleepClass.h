//
//  SleepClass.h
//  SleepTestApp
//
//  Created by sash on 20.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <IOKit/pwr_mgt/IOPMLib.h>

@interface SleepClass : NSObject

-(BOOL)checkSupportSleepMode;
-(void)goSleep;

@end
