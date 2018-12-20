//
//  MenuBar.h
//  SleepTestApp
//
//  Created by sash on 06.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
//
//
//  Иконка и меню в трее (в MenuBar)
//
//

#import <Foundation/Foundation.h>
#import "ImageWithMask.h"

@interface MenuBar : NSMenu {

    float thisProgress;
    
    BOOL timerStatus;
    
    IBOutlet NSMenu *statusMenu;

    NSStatusItem *statusItem;

    ImageWithMask *icon;
    
    IBOutlet NSWindow *mainWindow;
    IBOutlet NSWindow *settingsWindow;

}

// make Icon with new progress and status:
-(void)menuBarIconWithProgress:(float)progress withStatus:(BOOL)status;
// make Icon status with current progress:
-(void)menuBarIconStatus:(BOOL)status;

// when clicked to icon of status menu bar
- (void)openMenuAndWindow:(id)sender;

@end
