//
//  NKVolumeControl.h
//  SleepTestApp
//
//  Created by sash on 01.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioServices.h>

@interface NKVolumeControl : NSObject{
    IBOutlet NSTextField* volumeLabel;
    IBOutlet NSSlider* slider;
}

+ (float)getVolume;
+ (void)setVolume:(Float32)newVolume;
+ (AudioDeviceID)defaultOutputDeviceID;

@end
