//
//  Controller.h
//  SleepTestApp
//
//  Created by sash on 20.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Controller : NSObject
{
    
    NSUserDefaults *prefs;

    BOOL visibleMainWindow;
    
    IBOutlet NSButton* uiButtonHide;
    
    IBOutlet NSWindow* settingsWindow;
    IBOutlet NSWindow* mainWindow;
    IBOutlet NSMenuItem *showHideButton;
    IBOutlet NSButton *checkboxVisibleMainWindowAtStart;
    
}

-(IBAction)optionVisibleMainWindowAtStart:(id)sender;

-(IBAction)showSettingsWindow:(id)sender;
-(IBAction)hideSettingsWindow:(id)sender;
-(IBAction)showHideWindow:(id)sender;

-(void)hideMainWindow;
-(void)showMainWindow;

@end
