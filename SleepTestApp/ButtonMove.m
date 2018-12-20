//
//  ButtonMove.m
//  SleepTestApp
//
//  Created by sash on 16.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ButtonMove.h"

@implementation ButtonMove

- (void)mouseDown:(NSEvent *)theEvent {

//    if ([theEvent clickCount] > 1) {
//        NSLog(@"dubble click!");
//        [[self window] miniaturize:self];
//        return;
//    }

}

//- (void)mouseUp:(NSEvent *)theEvent {
    //NSLog(@"MouseUp");
//}


//- (void)mouseDown:(NSEvent *)theEvent {
//    
//    closeBox = NSMakeRect(0, 0, 200, 256);
//    
//    // mouseInCloseBox and trackingCloseBoxHit are instance variables
//    
//    if (mouseInCloseBox = NSPointInRect([self convertPoint:[theEvent locationInWindow] fromView:nil], closeBox)) {
//        trackingCloseBoxHit = YES;
//        [self setNeedsDisplayInRect:closeBox];
//    }
//    else if ([theEvent clickCount] > 1) {
//        NSLog(@"dubble click!");
//        //[[self window] miniaturize:self];
//        return;
//    }
//}


//-(void)mouseDragged:(NSEvent *)theEvent {
//    
//    NSPoint windowOrigin;
//    NSWindow *window = [self window];
//    
//    if (trackingCloseBoxHit) {
//        mouseInCloseBox = NSPointInRect([self convertPoint:[theEvent locationInWindow] fromView:nil], closeBox);
//        [self setNeedsDisplayInRect:closeBox];
//
//        return;
//    }
//    
//    windowOrigin = [window frame].origin;
//    
//    [window setFrameOrigin:NSMakePoint(windowOrigin.x + [theEvent deltaX], windowOrigin.y - [theEvent deltaY])];
//
//    [self setNeedsDisplay:YES];
//    [self setNeedsDisplay];
//    
//}
//
//
//- (void)mouseUp:(NSEvent *)theEvent {
//    if (NSPointInRect([self convertPoint:[theEvent locationInWindow] fromView:nil], closeBox)) {
//        NSLog(@"CLOSEEE!!");
//        return;
//    }
//    trackingCloseBoxHit = NO;
//    [self setNeedsDisplayInRect:closeBox];
//}




-(void)mouseDragged:(NSEvent *)theEvent {
    
    NSWindow* window = [self window];
    
    NSPoint where = [theEvent locationInWindow];
    //if (...test for your rect here...) {
    where =  [window convertBaseToScreen:where];
    NSPoint origin = [window frame].origin;
    // Now we loop handling mouse events until we get a mouse up event.
    while ((theEvent = [NSApp nextEventMatchingMask:NSLeftMouseDownMask|NSLeftMouseDraggedMask|NSLeftMouseUpMask untilDate:[NSDate distantFuture] inMode:NSEventTrackingRunLoopMode dequeue:YES])&&([theEvent type]!=NSLeftMouseUp)) {
        // Set up a local autorelease pool for the loop to prevent buildup of temporary objects.
        NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
        NSPoint now = [window convertBaseToScreen:[theEvent locationInWindow]];
        origin.x += now.x-where.x;
        origin.y += now.y-where.y;
        // Move the window by the mouse displacement since the last event.
        [window setFrameOrigin:origin];
        where = now;
        [pool release];
    }
    //}
}



@end
