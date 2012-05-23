//
//  InspectorController.m
//  Sim
//
//  Created by Ben Sinclair on 2/29/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import "InspectorController.h"

@implementation InspectorController

@synthesize program;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    
}

-(void)updateDisplay {
    [nameLabel setStringValue:program.name];
    [aLabel setIntValue:program.a];
    [bLabel setIntValue:program.b];
    [cLabel setIntValue:program.c];
    [dLabel setIntValue:program.d];
    [eLabel setIntValue:program.e];
    
    NSString *code = @"";
    
    for (NSString *line in program.code) {
        code = [NSString stringWithFormat:@"%@%@\n", code, line];
    }
    
    [codeField setString:code];
}

@end
