//
//  World.m
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import "World.h"

@implementation World

@synthesize programs;

-(void)generateWorld {
    programs = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        Program *p = [[Program alloc] init];
        [p generateProgram];
        p.age = 0;
        p.name = [NSString stringWithFormat:@"Program %i", i];
        p.resources = 100;
        p.x = arc4random() % 10;
        p.y = arc4random() % 10;
        [programs addObject:p];   
        NSLog(@"Adding program!");
    }
    
    for (int i = 0; i < 100; i++) {
        world[arc4random() % 100][arc4random() % 100] = [NSNumber numberWithInt:1];
    }
    
}

@end
