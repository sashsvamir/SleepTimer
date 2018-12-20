//
//  ImageWithMask.h
//  SleepTestApp
//
//  Created by sash on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
//
//
//  Класс рисует иконки для menu bar, dock и маску для прогресса основного окна
//
//

#import <Foundation/Foundation.h>

@interface ImageWithMask : NSObject{
    
    NSColor *foregroundColor;
    NSColor *backgroundColor;

}


@property (copy) NSColor *foregroundColor;
@property (copy) NSColor *backgroundColor;


- (NSImage *)progressLevelOfSize:(float)size withProgress:(float)progress;
- (NSImage *)progressMaskOfSize:(float)size withProgress:(float)progress;

- (NSImage *)maskImage:(NSImage *)image withMask:(NSImage *)maskImage;

- (CGImageRef)cgimageFromNSImage:(NSImage *)image;
- (NSImage *) nsimageFromCGImageRef:(CGImageRef)image;


// Menu Bar icon progress:
- (NSImage *)menuBarIconWithProgress:(float)progress withStatus:(BOOL)status;


// Dock icon progress
//- (void)badgeApplicationDockIconWithProgress:(float)progress insetX:(float)dx y:(float)dy;
//- (NSImage *)badgeOverlayImageWithProgress:(float)progress insetX:(float)dx y:(float)dy;
//- (NSImage *)progressBadgeOfSize:(float)size withProgress:(float)progress;


@end
