//
//  GrowlNotifycation.m
//  SleepTestApp
//
//  Created by sash on 16.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GrowlNotifycation.h"

#define NotifierFireWireDisconnectionNotification		@"FireWire Device Disconnected"
#define NotifierFireWireDisconnectionHumanReadableDescription		NSLocalizedString(@"FireWire Device Disconnected", "")

@implementation GrowlNotifycation





- (void) awakeFromNib{
    //
    // Growl code begin:
    //
    NSBundle *mainBundle = [NSBundle mainBundle];
	NSString *path = [[mainBundle privateFrameworksPath] stringByAppendingPathComponent:@"Growl"];
	if(NSAppKitVersionNumber >= 1038)
		path = [path stringByAppendingPathComponent:@"1.3"];
	else
		path = [path stringByAppendingPathComponent:@"1.2.3"];
	
	path = [path stringByAppendingPathComponent:@"Growl.framework"];
	NSLog(@"path: %@", path);
	NSBundle *growlFramework = [NSBundle bundleWithPath:path];
	if([growlFramework load])
	{
		NSDictionary *infoDictionary = [growlFramework infoDictionary];
		NSLog(@"Using Growl.framework %@ (%@)",
			  [infoDictionary objectForKey:@"CFBundleShortVersionString"],
			  [infoDictionary objectForKey:(NSString *)kCFBundleVersionKey]);
        
		Class GAB = NSClassFromString(@"GrowlApplicationBridge");
		if([GAB respondsToSelector:@selector(setGrowlDelegate:)])
			[GAB performSelector:@selector(setGrowlDelegate:) withObject:self];
	}
    //
    // Growl code end
    //
    
    //[GrowlNotifycation notify:@"asdsfsfasfasfasfasfasfasfasfasf"];
    //[self notify];

}



// Grown code begin:
- (NSDictionary *) registrationDictionaryForGrowl {
	NSDictionary *notificationsWithDescriptions = [NSDictionary dictionaryWithObjectsAndKeys: NotifierFireWireDisconnectionHumanReadableDescription, NotifierFireWireDisconnectionNotification, nil];
	
	NSArray *allNotifications = [notificationsWithDescriptions allKeys];
	
	//Don't turn the sync notiifications on by default; they're noisy and not all that interesting.
	NSMutableArray *defaultNotifications = [allNotifications mutableCopy];
	//[defaultNotifications removeObject:NotifierSyncStartedNotification];
	//[defaultNotifications removeObject:NotifierSyncFinishedNotification];
	
	NSDictionary *regDict = [NSDictionary dictionaryWithObjectsAndKeys:
							 @"MultiGrowlExample", GROWL_APP_NAME,
							 allNotifications, GROWL_NOTIFICATIONS_ALL,
							 defaultNotifications,	GROWL_NOTIFICATIONS_DEFAULT,
							 notificationsWithDescriptions,	GROWL_NOTIFICATIONS_HUMAN_READABLE_NAMES,
							 nil];
	
	[defaultNotifications release];
	
	return regDict;
}




static NSData* firewireLogo(void)
{
	static NSData* firewireLogoData = nil;
	
	if (!firewireLogoData) {
		NSString *path = [[NSBundle mainBundle] pathForImageResource:@"FireWireLogo"];
		if(path)
			firewireLogoData = [[NSData alloc] initWithContentsOfFile:path];
	}
	return firewireLogoData;
}



-(void)notifycation:(NSString *)message title:(NSString *)title{
    
    Class GAB = NSClassFromString(@"GrowlApplicationBridge");
	if([GAB respondsToSelector:@selector(notifyWithTitle:description:notificationName:iconData:priority:isSticky:clickContext:identifier:)])
		[GAB notifyWithTitle:title
                 description:message
            notificationName:(NSString *)NotifierFireWireDisconnectionNotification
                    iconData:(NSData *)firewireLogo()
                    priority:0
                    isSticky:NO
                clickContext:nil
                  identifier:@"After 1 min Mac go sleep, good bye!"];

}


+ (void)notify:(NSString *)message{
    
//    va_list args;
//    va_start(args, message);
//    NSLogv(format, args);   
//    va_end(args);
    
    NSLog(@"\nGrowl Notifycation before 1 min to sleep! (Args:\"%@\")\n", message);
    
	Class GAB = NSClassFromString(@"GrowlApplicationBridge");
	if([GAB respondsToSelector:@selector(notifyWithTitle:description:notificationName:iconData:priority:isSticky:clickContext:identifier:)])
		[GAB notifyWithTitle:message
                 description:@"After 1 min Mac go sleep, good bye!"
            notificationName:(NSString *)NotifierFireWireDisconnectionNotification
                    iconData:(NSData *)firewireLogo()
                    priority:0
                    isSticky:NO
                clickContext:nil
                  identifier:@"After 1 min Mac go sleep, good bye!"];
	
}

// Growl code end

    





@end
