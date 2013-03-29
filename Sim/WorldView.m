//
//  WorldView.m
//  Sim
//
//  Created by Ben Sinclair on 2/28/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import "WorldView.h"

#define PROGRAM_SIZE 6
#define RESOURCE_SIZE 4


@implementation WorldView

@synthesize world, selectedProgram;

- (id)initWithFrame:(NSRect)frameRect
{
    self = [super initWithFrame:frameRect];
    selectedProgram = -1;
    return self;
}

- (void)drawRect:(NSRect)rect
{    
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul), ^{
    
    CGContextRef myContext = [[NSGraphicsContext currentContext] graphicsPort];
    
    CGContextSetRGBFillColor (myContext, 0, 0, 0, .5);// 5
    CGContextFillRect (myContext, CGRectMake (0, 0, self.frame.size.width, self.frame.size.height));    

    /* Removed stroked grid that took a vast amount of time for limited benefit */
    
    for (Program *p in world.programs)
    {
        if (p) {
            if (p.programId == selectedProgram) {
                CGContextSetRGBFillColor (myContext, 0, 1, 0, .9);// 5
            } else if (p.e > 0) {
                CGContextSetRGBFillColor (myContext, 0, 0, 1, .5);// 5
            } else {
                CGContextSetRGBFillColor (myContext, 1, 0, 0.5, .5);// 5
            }
            
            CGContextFillRect (myContext, CGRectMake (p.x * PROGRAM_SIZE, p.y * PROGRAM_SIZE, PROGRAM_SIZE, PROGRAM_SIZE));
        }

    }
    
    for (int x = 0; x < 100; x++) {
        for (int y = 0; y < 100; y++) {
            if ([world objectAtX:x Y:y] == 1) {
                CGContextSetRGBFillColor (myContext, 0, 1, 1, .5);// 5
                CGContextFillRect (myContext, CGRectMake (x * PROGRAM_SIZE + ((PROGRAM_SIZE - RESOURCE_SIZE)/2), y * PROGRAM_SIZE + ((PROGRAM_SIZE - RESOURCE_SIZE)/2), RESOURCE_SIZE, RESOURCE_SIZE));
            }             
        }
    }
        
    //});
}

@end