//
//  GrowlNotifycation.h
//  SleepTestApp
//
//  Created by sash on 16.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Growl/Growl.h>
@interface GrowlNotifycation : NSObject

-(void)notifycation:(NSString *)message title:(NSString *)title;

@end
