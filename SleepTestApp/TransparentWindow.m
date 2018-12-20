//
//  TransparentWindow.m
//  SleepTestApp
//
//  Created by sash on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransparentWindow.h"


@implementation TransparentWindow


- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSWindowStyleMask)windowStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)deferCreation
{
    self = [super
            initWithContentRect:contentRect
            styleMask:NSBorderlessWindowMask
            backing:bufferingType
            defer:deferCreation];
    if (self)
    {
        [self setOpaque:NO];
        //[self setAlphaValue:0.5];
        [self setBackgroundColor:[NSColor clearColor]];

    }
    
    return self;
}


@end
