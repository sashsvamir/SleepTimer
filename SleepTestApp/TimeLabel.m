//
//  TimeLabel.m
//  SleepTestApp
//
//  Created by sash on 18.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TimeLabel.h"

@implementation TimeLabel

@synthesize setTimeAlrady;


-(void)awakeFromNib {
    
    if (setTimeAlrady == NO) {
        [self setStringValue:@"--:--"];
    }

}


-(void)setNewTime:(int)t {
    
    [self setStringValue:[self remainderTime:t]];
    setTimeAlrady = YES;

}



// return time (00:00) format from seconds (600)
-(NSString *)remainderTime:(int)t {
    
    NSString *min;
    NSString *sec;
    
    if ( t/60 < 10 ) {
        // one digit make with zero aka 09:01
        min = [NSString stringWithFormat:@"0%@", [NSNumber numberWithInt:t/60]];
    } else {
        // two digits ok
        min = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:t/60]];
    }
    
    if ( t%60 < 10 ) {
        // one digit make with zero aka 09:01
        sec = [NSString stringWithFormat:@"0%@", [NSNumber numberWithInt:t%60]];
    } else {
        // two digits ok
        sec = [NSString stringWithFormat:@"%@", [NSNumber numberWithInt:t%60]];    
    }
    
	// NSMutableString
	NSString *minAndSec = [NSString stringWithFormat:@"%@:%@", min, sec];
    
    return minAndSec;
}

@end
