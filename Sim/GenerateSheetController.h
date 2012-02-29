//
//  GenerateSheetController.h
//  Sim
//
//  Created by Ben Sinclair on 2/28/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GenerateSheetController : NSWindowController {
    int programCount;
    int resourceCount;
    
    IBOutlet NSTextField *programsTextField;
    IBOutlet NSTextField *resourcesTextField;
}

@property (nonatomic, assign) int programCount;
@property (nonatomic, assign) int resourceCount;

-(IBAction)cancelClicked:(id)sender;
-(IBAction)continueClicked:(id)sender;

-(void)update;

@end
