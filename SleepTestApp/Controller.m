//
//  Controller.m
//  SleepTestApp
//
//  Created by sash on 20.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"

@implementation Controller


-(void)awakeFromNib{
    
    // initialize user preferences:
    prefs = [NSUserDefaults standardUserDefaults];
    
    // Activate ignore other app for Front this App behind of any applications:
    //[NSApp activateIgnoringOtherApps:YES];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];

    visibleMainWindow = [prefs boolForKey:@"VisibleMainWindowAtStart"];
    
    if (visibleMainWindow == NO){
        [checkboxVisibleMainWindowAtStart setState:NO];
        [self hideMainWindow];
    }else{
        [self showMainWindow];
    }
    
    [[uiButtonHide cell] setHighlightsBy:NSContentsCellMask];

}



-(void)hideMainWindow{
    [mainWindow orderOut:self];
    [settingsWindow orderOut:self];
    [showHideButton setTitle:@"Show"];
    visibleMainWindow = NO;
}
-(void)showMainWindow{
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    [mainWindow makeKeyAndOrderFront:self];
    [showHideButton setTitle:@"Hide"];
    visibleMainWindow = YES;
}




-(IBAction)showSettingsWindow:(id)sender{
    if ( ![settingsWindow isVisible] ){
        [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
        [settingsWindow makeKeyAndOrderFront:self];
    }
}

-(IBAction)hideSettingsWindow:(id)sender{
    if ( [settingsWindow isVisible] ){
        [settingsWindow orderOut:self];
    }
}





-(IBAction)showHideWindow:(id)sender{
    if (visibleMainWindow == NO) {
        [self showMainWindow];
    } else if (visibleMainWindow == YES) {
        [self hideMainWindow];
    }
}


-(IBAction)optionVisibleMainWindowAtStart:(id)sender{
    if ([checkboxVisibleMainWindowAtStart state] == NSOnState){
        [prefs setBool:YES forKey:@"VisibleMainWindowAtStart"];
        NSLog(@"VisibleMainWindowAtStart:YES");
    }else{
        [prefs setBool:NO forKey:@"VisibleMainWindowAtStart"];
        NSLog(@"VisibleMainWindowAtStart:NO");
    }
}



@end
