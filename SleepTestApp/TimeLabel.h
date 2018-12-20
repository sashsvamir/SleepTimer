//
//  TimeLabel.h
//  SleepTestApp
//
//  Created by sash on 18.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>


@interface TimeLabel : NSTextField{
    BOOL setTimeAlrady;    
}

@property (readwrite) BOOL setTimeAlrady;

-(NSString *)remainderTime:(int)t;
-(void)setNewTime:(int)t;

@end
