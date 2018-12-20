//
//  ImageWithMask.m
//  SleepTestApp
//
//  Created by sash on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageWithMask.h"

@implementation ImageWithMask


@synthesize foregroundColor;
@synthesize backgroundColor;

- (id)init {
    self = [super init];
    if (self != nil) {
        foregroundColor = nil;
        backgroundColor = nil;
        [self setForegroundColor:[NSColor blackColor]];
        [self setBackgroundColor:[NSColor whiteColor]];
    }
    return self;
}









// --------------------------------------
//            Main function
// Create Progress Level image with Mask:
// --------------------------------------
- (NSImage *)progressLevelOfSize:(float)size withProgress:(float)progress
{

    NSImage *imageButtonNS = [NSImage imageNamed:@"IB-progress-196px.png"];
    NSImage *imageButtonMask = [self progressMaskOfSize:size withProgress:progress];

    //CGImageRef imageButtonCG;
    //imageButtonCG = [self cgimageFromNSImage:imageButtonNS];
    //imageButtonNS = [self nsimageFromCGImageRef:imageButtonCG];
    
    //return imageButtonNS;
    //return imageButtonMask;
    
    return [self maskImage:imageButtonNS withMask:imageButtonMask];
}






// ----------------------------
// Generate Vector Pie for Mask
// ----------------------------
-(NSImage *)progressMaskOfSize:(float)size withProgress:(float)progress{
    
    // Create Progress image for Masking:
    
    NSRect pieRect = NSMakeRect(0,0,size,size);
    
    NSImage *progressBadge = [[NSImage alloc] initWithSize:NSMakeSize(size, size)];
    
    [progressBadge lockFocus];
    [NSGraphicsContext saveGraphicsState];
    
    [foregroundColor set];
    [[NSBezierPath bezierPathWithOvalInRect:pieRect] fill];
    [NSGraphicsContext restoreGraphicsState];
    
    //if(progress <= 0)
    //{
	//	[backgroundColor set];
    //}
    //else if(progress < 1)
    //{
    if (progress <=0) {
        progress = .0001;
    }
    //NSLog(@"float: %f", progress);
		[backgroundColor set];
		NSBezierPath *slice = [NSBezierPath bezierPath];
		[slice moveToPoint:NSMakePoint(NSMidX(pieRect),NSMidY(pieRect))];
		[slice appendBezierPathWithArcWithCenter:NSMakePoint(NSMidX(pieRect),NSMidY(pieRect)) radius:NSHeight(pieRect)/2+1 startAngle:-90 endAngle:-90-progress*360 clockwise:NO];
		[slice moveToPoint:NSMakePoint(NSMidX(pieRect),NSMidY(pieRect))];
		[slice fill];
    //}
    [progressBadge unlockFocus];
    
    return [progressBadge autorelease];
    
}






// ----------------------------
// Generate Image with Mask
// ----------------------------
- (NSImage*) maskImage:(NSImage *)image withMask:(NSImage *)maskImage {
    
	CGImageRef maskRef = [self cgimageFromNSImage:maskImage];
    CGImageRef imageRef = [self cgimageFromNSImage:image];
    
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);

	
    
    CGImageRef masked = CGImageCreateWithMask(imageRef, mask);
    
    NSImage *newImage = [self nsimageFromCGImageRef:masked];
    
    CGImageRelease(maskRef);
    CGImageRelease(imageRef);
    CGImageRelease(mask);
    CGImageRelease(masked);
    
    return newImage;
    
}




// ----------------------------
// Create CGImage from NSImage:
// ----------------------------
- (CGImageRef)cgimageFromNSImage:(NSImage *)image{
    
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[image TIFFRepresentation], NULL);
    CGImageRef newImage =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    CFRelease(source);
    //CFRelease(newImage);
    
    return newImage;
}


// ----------------------------
// Create NSImage from CGImage:
// ----------------------------
-(NSImage *)nsimageFromCGImageRef:(CGImageRef)image{
    
    NSImage* newImage = nil;
    NSBitmapImageRep* newRep = [[NSBitmapImageRep alloc] initWithCGImage:image];
    NSSize imageSize;
    
    imageSize.height = CGImageGetHeight(image);
    imageSize.width = CGImageGetWidth(image);
    
    newImage = [[NSImage alloc] initWithSize:imageSize];
    [newImage addRepresentation:newRep];
    
    [newRep release];
    
    return [newImage autorelease];
}









































//
//
//  Menu Bar Icon
//
//
- (NSImage *)menuBarIconWithProgress:(float)progress withStatus:(BOOL)status {
    
    
    // make NSImage for icon:
    NSImage *progressIcon = [[NSImage alloc] initWithSize:NSMakeSize(20, 20)];
    [progressIcon lockFocus];
    
    // make shadow of icon content
    NSShadow *theShadow = [[NSShadow alloc] init];
    [theShadow setShadowOffset: NSMakeSize(0, -1)];
    [theShadow setShadowBlurRadius:1];
    [theShadow setShadowColor:[[NSColor whiteColor] colorWithAlphaComponent:.9]];
    [theShadow set];
    [theShadow release];
    
    // make color SET:
    if (status == 1){
        [[NSColor blackColor] set];
    } else {
        [[[NSColor blackColor] colorWithAlphaComponent:.4] set];
    }

    // make progress pie:    
    NSBezierPath *pie = [NSBezierPath bezierPath];
    NSPoint center = { 9.5, 9.5 };
    [pie moveToPoint: center];
    [pie appendBezierPathWithArcWithCenter: center
                                    radius: 5
                                startAngle: -90
                                  endAngle: -90-progress*360
                                 clockwise: YES];
    [pie fill];
    
    // make path circle around progress:
    NSRect mainOval = { 2, 2, 15, 15 };
    NSBezierPath *circle = [NSBezierPath bezierPathWithOvalInRect:mainOval];
    [circle stroke];
    
    
    [progressIcon unlockFocus];

    return [progressIcon autorelease];
}


































// ---------------------------------------
//          Dock icon progress
// ---------------------------------------

//- (void)badgeApplicationDockIconWithProgress:(float)progress insetX:(float)dx y:(float)dy
//{
//    NSImage *appIcon      = [NSImage imageNamed:@"NSApplicationIcon"];
//    NSImage *badgeOverlay = [self badgeOverlayImageWithProgress:progress insetX:dx y:dy];
//    
//    //Put the appIcon underneath the badgeOverlay
//    [badgeOverlay lockFocus];
//	[appIcon compositeToPoint:NSZeroPoint operation:NSCompositeDestinationOver];
//    [badgeOverlay unlockFocus];
//    [[badgeOverlay TIFFRepresentation] writeToFile:@"/tmp/badge.tif" atomically:NO];
//    [NSApp setApplicationIconImage:badgeOverlay];
//}
//
//
//
//
//- (NSImage *)badgeOverlayImageWithProgress:(float)progress insetX:(float)dx y:(float)dy
//{
//    NSImage *badgeImage = [self progressBadgeOfSize:42 withProgress:progress];
//    NSImage *overlayImage = [[NSImage alloc] initWithSize:NSMakeSize(128,128)];
//    
//    //draw large icon in the upper right corner of the overlay image
//    [overlayImage lockFocus];
//    NSSize badgeSize = [badgeImage size];
//    [badgeImage compositeToPoint:NSMakePoint(128-dx-badgeSize.width,128-dy-badgeSize.height) operation:NSCompositeSourceOver];  
//    [overlayImage unlockFocus];
//    
//    return [overlayImage autorelease];
//}
//
//
//
//
//- (NSImage *)progressBadgeOfSize:(float)size withProgress:(float)progress
//{
//    float scaleFactor = size/16;
//    float stroke = 2*scaleFactor;	//native size is 16 with a stroke of 2
//    float shadowBlurRadius = 1*scaleFactor;
//    float shadowOffset = 1*scaleFactor;
//    
//    float shadowOpacity = .4;
//    
//    NSRect pieRect = NSMakeRect(shadowBlurRadius,shadowBlurRadius+shadowOffset,size,size);
//    
//    NSImage *progressBadge = [[NSImage alloc] initWithSize:NSMakeSize(size + 2*shadowBlurRadius, size + 2*shadowBlurRadius+1)];
//    
//    [progressBadge lockFocus];
//    [NSGraphicsContext saveGraphicsState];
//    NSShadow *theShadow = [[NSShadow alloc] init];
//    [theShadow setShadowOffset: NSMakeSize(0,-shadowOffset)];
//    [theShadow setShadowBlurRadius:shadowBlurRadius];
//    [theShadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:shadowOpacity]];
//    [theShadow set];
//    [theShadow release];
//    [foregroundColor set];
//    [[NSBezierPath bezierPathWithOvalInRect:pieRect] fill];
//    [NSGraphicsContext restoreGraphicsState];
//    
//    if(progress <= 0)
//    {
//		[backgroundColor set];
//		[[NSBezierPath bezierPathWithOvalInRect:NSMakeRect(NSMinX(pieRect)+stroke,NSMinY(pieRect)+stroke, NSWidth(pieRect)-2*stroke,NSHeight(pieRect)-2*stroke)] fill];
//    }
//    else if(progress < 1)
//    {
//		[backgroundColor set];
//		NSBezierPath *slice = [NSBezierPath bezierPath];
//		[slice moveToPoint:NSMakePoint(NSMidX(pieRect),NSMidY(pieRect))];
//		[slice appendBezierPathWithArcWithCenter:NSMakePoint(NSMidX(pieRect),NSMidY(pieRect)) radius:NSHeight(pieRect)/2-stroke startAngle:-90 endAngle:-90-progress*360 clockwise:NO];
//		[slice moveToPoint:NSMakePoint(NSMidX(pieRect),NSMidY(pieRect))];
//		[slice fill];
//    }
//    [progressBadge unlockFocus];
//    
//    return [progressBadge autorelease];
//}

@end
