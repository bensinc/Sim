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
    [logTextView setInsertionPointColor:[NSColor cyanColor]];
    [[[logTextView textStorage] mutableString] appendString: @"Sim starting...\n"];
    [[[logTextView textStorage] mutableString] appendString: @"Ready.\n"];
    
    world = [[World alloc] init];
    [world generateWorld];
    
    worldView.world = world;

    running = NO;    
    
    sleepTime = 80000;
}

-(void)refreshDisplay {
    [worldView setNeedsDisplay:YES];        
    [programsTable reloadData];    
}

-(void)runWorld {
    NSLog(@"STARTED RUN THREAD!");
    while(running) {
//        NSLog(@"Cycle");        
        [world runCycle];        
        [self performSelectorOnMainThread:@selector(refreshDisplay) withObject:nil waitUntilDone:NO];
        usleep(sleepTime);
    }
    NSLog(@"ENDED RUN THREAD!");    
}


-(void)inspect {

    if (!inspector)
        inspector = [[InspectorController alloc] initWithWindowNibName:@"Inspector"];
    
    inspector.program = selectedProgram;
    [inspector showWindow:window];
    [inspector updateDisplay];
    
    
}


- (void)showCustomSheet: (NSWindow *)win

// User has asked to see the custom display. Display it.
{

    
    GenerateSheetController *controller = [[GenerateSheetController alloc] initWithWindowNibName:@"GenerateSheet"];
    
    controller.resourceCount = 1000;
    controller.programCount = 30;
    
    [controller update];

    [NSApp beginSheet: controller.window
       modalForWindow: window
        modalDelegate: self
       didEndSelector: @selector(didEndSheet:returnCode:contextInfo:)
          contextInfo: controller];
    
    // Sheet is up here.
    // Return processing to the event loop
}

-(IBAction)generateClicked:(id)sender {

    
    [worldView setNeedsDisplay:YES];
    [programsTable reloadData];
    running = NO;    
    [runButton setImage:[NSImage imageNamed:@"play"]];
    [runButton setLabel:@"Run"];    
    
    [self showCustomSheet:window];
}

- (void)didEndSheet:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    [sheet orderOut:self];    
    
    if (((GenerateSheetController*)contextInfo).programCount > -1) {
        world = [[World alloc] init];
        world.programCount = ((GenerateSheetController*)contextInfo).programCount;
        world.resourceCount = ((GenerateSheetController*)contextInfo).resourceCount;
    
        [world generateWorld];    
        worldView.world = world;    
        [self refreshDisplay];
    }
}

-(IBAction)runClicked:(id)sender {
    if (running) {
        running = NO;
        [runButton setImage:[NSImage imageNamed:@"play"]];
        [runButton setLabel:@"Run"];
    } else {
        [runButton setImage:[NSImage imageNamed:@"pause"]];        
        [runButton setLabel:@"Pause"];        
        running = YES;
        [NSThread detachNewThreadSelector:@selector(runWorld) toTarget:self withObject:nil];
    }
}


-(IBAction)speedClicked:(id)sender {
    
    if ([((NSToolbarItem*)sender) tag] == 1)
        sleepTime = 160000;
    
    if ([((NSToolbarItem*)sender) tag] == 2)
        sleepTime = 80000;

    if ([((NSToolbarItem*)sender) tag] == 3)
        sleepTime = 40000;
    
    
}

#pragma mark table data source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [world.programs count];
//    return 0;
}

- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
            row:(NSInteger)row
{
    Program *p = [world.programs objectAtIndex:row];
    
    if ([[tableColumn identifier] isEqualToString:@"name"]) {
        return p.name;
    } else if ([[tableColumn identifier] isEqualToString:@"age"]) {
        return [NSString stringWithFormat:@"%i", p.age];        
    } else if ([[tableColumn identifier] isEqualToString:@"energy"]) {
        return [NSString stringWithFormat:@"%i", p.e];        
    }
    
    return(@"");
}


#pragma mark table view delgate

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    Program *p = [world.programs objectAtIndex:programsTable.selectedRow];
    [[[logTextView textStorage] mutableString] appendString: [NSString stringWithFormat:@"Selected program: %@\n", p.name]];
    
    for (NSString *line in p.code) {
        [[[logTextView textStorage] mutableString] appendString: [NSString stringWithFormat:@"%@\n", line]];        
    }
    running = NO;
    worldView.selectedProgram = p.programId;
    selectedProgram = p;
    [worldView setNeedsDisplay:YES];
    
    [self inspect];
    

}

@end
