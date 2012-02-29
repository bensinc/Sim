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

#import "GenerateSheetController.h"

@interface MainController : NSObject <NSTableViewDataSource, NSTableViewDelegate> {
    IBOutlet NSTextView *logTextView;
    IBOutlet WorldView *worldView;
    IBOutlet NSTableView *programsTable;
    IBOutlet NSToolbarItem *runButton;
    
    NSWindow *generateSheet;
    IBOutlet NSWindow *window;

    
    World *world;
    BOOL running;
    
    int sleepTime;
}

-(IBAction)generateClicked:(id)sender;
-(IBAction)runClicked:(id)sender;
-(IBAction)speedClicked:(id)sender;

@end
