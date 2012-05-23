//
//  InspectorController.h
//  Sim
//
//  Created by Ben Sinclair on 2/29/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Program.h"

@interface InspectorController : NSWindowController {
    Program *program;
    IBOutlet NSTextField *nameLabel;
    IBOutlet NSTextField *aLabel;
    IBOutlet NSTextField *bLabel;
    IBOutlet NSTextField *cLabel;
    IBOutlet NSTextField *dLabel; 
    IBOutlet NSTextField *eLabel;  
    
    IBOutlet NSTextView *codeField;

}

@property (nonatomic, retain) Program *program;

-(void)updateDisplay;

@end
