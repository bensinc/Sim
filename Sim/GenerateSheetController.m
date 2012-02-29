//
//  GenerateSheetController.m
//  Sim
//
//  Created by Ben Sinclair on 2/28/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import "GenerateSheetController.h"

@implementation GenerateSheetController

@synthesize programCount, resourceCount;

- (void)windowDidLoad
{
    [super windowDidLoad];
    

    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)update {
    [programsTextField setIntValue:self.programCount];
    [resourcesTextField setIntValue:self.resourceCount];    
}




-(IBAction)cancelClicked:(id)sender {
    self.programCount = -1;
    [NSApp endSheet:self.window];

}

-(IBAction)continueClicked:(id)sender {
    self.programCount = [programsTextField intValue];
    self.resourceCount = [resourcesTextField intValue];    
    [NSApp endSheet:self.window];    
}

@end
