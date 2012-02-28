//
//  MainController.m
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import "MainController.h"

@implementation MainController

-(void)awakeFromNib {
    NSLog(@"Awake from nib!");
    [logTextView setInsertionPointColor:[NSColor cyanColor]];
    [logTextView setFont:[NSFont fontWithName:@"Cambria" size:20.0]];
//    [logTextView insertText:@"Sim started."];
    [[[logTextView textStorage] mutableString] appendString: @"Sim starting...\n"];
    [[[logTextView textStorage] mutableString] appendString: @"Ready.\n"];
    
//    Program *p = [[Program alloc] init];
//    [p generateProgram];
//    
//    NSLog(@"Code size: %ld", (long)[p.code count]);
//    
//    for (NSString* line in p.code) {
//        [[[logTextView textStorage] mutableString] appendString: line];
//        [[[logTextView textStorage] mutableString] appendString: @"\n"];        
//    }
    
    world = [[World alloc] init];
    [world generateWorld];
    
    worldView.world = world;

    running = YES;    
    
    [NSThread detachNewThreadSelector:@selector(runWorld) toTarget:self withObject:nil];


}

-(void)runWorld {
    while(running) {
        NSLog(@"Cycle");        
        [world runCycle];
        [worldView setNeedsDisplay:YES];
        sleep(1);

    }
}

@end
