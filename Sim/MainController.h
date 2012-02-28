//
//  MainController.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"
#import "World.h"
#import "WorldView.h"

@interface MainController : NSObject {
    IBOutlet NSTextView *logTextView;
    IBOutlet WorldView *worldView;
    
    World *world;
    BOOL running;
}

@end
