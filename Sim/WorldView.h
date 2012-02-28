//
//  WorldView.h
//  Sim
//
//  Created by Ben Sinclair on 2/28/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "World.h"

@interface WorldView : NSView {
    World *world;
}

@property (nonatomic, retain) World *world;

@end
