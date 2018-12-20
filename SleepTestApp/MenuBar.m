//
//  MenuBar.m
//  SleepTestApp
//
//  Created by sash on 06.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuBar.h"

@implementation MenuBar

// этот init нужен чтобы theProgress=1 не выполнялся после того когда иконка menu bar уже нарисована с правильным progress:
- (id)init {
    self = [super init];
    if (self != nil) {
        thisProgress = 1;
    }
    return self;
}


-(void)awakeFromNib{

    //Create the NSStatusBar and set its length
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
    
    //Tells the NSStatusItem what menu to load
    //[statusItem setMenu:statusMenu];
    
    //Sets the tooptip for our item
    [statusItem setToolTip:@"SleepTimer Menu"];
    
    //Enables highlighting
    [statusItem setHighlightMode:YES];

    // Sets the image of NSStatusItem
    [self menuBarIconWithProgress:thisProgress withStatus:0];
    
    [statusItem setTarget:self];
    [statusItem setAction:@selector(openMenuAndWindow:)];

}




- (void)openMenuAndWindow:(id)sender{
    if ( ![NSApp isActive] && ![NSApp mainWindow] ){
        if ( [mainWindow isVisible] ){
            [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
            [mainWindow makeKeyAndOrderFront:self];
        }
        if ( [settingsWindow isVisible] ){
            [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
            [settingsWindow  makeKeyAndOrderFront:self];
        }
    }
    [statusItem popUpStatusItemMenu:statusMenu];
}




-(void)menuBarIconWithProgress:(float)progress withStatus:(BOOL)status{
    
    thisProgress = progress;
    
    icon = [[ImageWithMask alloc] init];
    
    NSImage *menuIcon = [icon menuBarIconWithProgress:progress withStatus:status];
    [menuIcon setTemplate:YES];
    [statusItem setImage:menuIcon];
    [icon release];

}

-(void)menuBarIconStatus:(BOOL)status{

    icon = [[ImageWithMask alloc] init];
    [statusItem setImage:[icon menuBarIconWithProgress:thisProgress withStatus:status]];
    [icon release];

}












@end
