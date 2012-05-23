//
//  World.m
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import "World.h"

#define ENERGY_VALUE 5

@implementation World

@synthesize programs, newPrograms, programCount, resourceCount, programsSize;

-(void)generateWorld {
    programs = [[CCArray arrayWithCapacity:1000] retain];
    
    
    for (int i = 0; i < programCount; i++) {
        Program *p = [[[Program alloc] init] retain];
        [p generateProgram];
        p.age = 0;
        p.name = [NSString stringWithFormat:@"Program %i", i];
        p.resources = 100;
        p.x = arc4random() % 100;
        p.y = arc4random() % 100;
        p.programId = i;
        [programs addObject:p];  
//        NSLog(@"Adding program!");
    }
    
    programsSize = programCount;
    
    for (int i = 0; i < resourceCount; i++) {
        world[arc4random() % 100][arc4random() % 100] = 1;
    }
    
}

-(Program*)getProgram:(int)i {
//    NSLog(@"Get program: %i", i);
    
    if (programsArray[i])
        return programsArray[i];
    else
        return nil;
}

-(int)objectAtX:(int)x Y:(int)y {
    return(world[x][y]);
}

-(void)reproduce:(Program*)p with:(Program*)op {
//    NSLog(@"Reproduce begin: %@ with %@", p.name, op.name);
    Program *newP = [[Program alloc] init];
    newP.code = [[NSMutableArray alloc] init];
    programCount++;
    newP.programId = programCount;
    newP.name = [NSString stringWithFormat:@"Program R%i", newP.programId];

    for (int i = 0; i < 10; i++) {
        if ([[p.code objectAtIndex:i] isEqualToString:[op.code objectAtIndex:i]]) {
            [newP.code addObject:[p.code objectAtIndex:i]];
        } else {
            [newP.code addObject:[newP generateInstruction:YES]];
        }
    }
    
    newP.x = arc4random() % 100;
    newP.y = arc4random() % 100;    
    
    [self.newPrograms addObject:newP];
    
//    NSLog(@"New program: %@", newP.name);
}


-(void)runInstructionForProgram:(Program*)p chunks:(NSArray*)chunks {
    
//    NSLog(@"INSTRUCTION: %@", [chunks objectAtIndex:0]);
    
    if([[chunks objectAtIndex:0] isEqualToString:@"move"]) {
        //                    NSLog(@"Move: %@", line);
//        [p useEnergy]; // Use 1 energy per move
        [p move:[chunks objectAtIndex:1]];
        
        if ([self objectAtX:p.x Y:p.y] == 1) {
            p.e = p.e + ENERGY_VALUE;
            world[p.x][p.y] = 0;
        }
        
        Program* op;
        CCARRAY_FOREACH(programs, op) {              
            if (op && op != p && op.e > 0) {
                if (op.x == p.x && op.y == p.y) {                        
                    [self reproduce:p with:op];
                }
            }
        }        
       
    }
    
    if([[chunks objectAtIndex:0] isEqualToString:@"deposit"]) {
        //                    NSLog(@"Deposit");
        if ([self objectAtX:p.x Y:p.y] == 0) {
//            NSLog(@"Before: %i", p.e);
            p.e = p.e - ENERGY_VALUE;
//            NSLog(@"After: %i", p.e);            
            world[p.x][p.y] = 1;                 
        }
    }                
    
    if([[chunks objectAtIndex:0] isEqualToString:@"look"]) {                    
        //                    NSLog(@"Look");
        int v = [p getValue:[chunks objectAtIndex:1]];
        
        int x = p.x;
        int y = p.y;
        
        
        switch(v) {
            case 1:
                x--;
                y--;
            case 2:
                x--;
            case 3:
                x--;
                y++;
            case 4:
                x++;
            case 5:
                x++;
                y++;
            case 6:
                y++;
            case 7:
                x++;
                y--;
            case 8:
                y--;
                
        }
        
        if (x > 100)
            x = 0;
        
        if (x < 0)
            x = 100;
        
        if (y > 100)
            y = 0;
        
        if (y < 0)
            y = 100;
        
        p.a = [self objectAtX:x Y:y];
        
    }
    
    if([[chunks objectAtIndex:0] isEqualToString:@"add"]) {                    
        //                    NSLog(@"Add");
        [p add:[chunks objectAtIndex:1]];
    }
    
    if([[chunks objectAtIndex:0] isEqualToString:@"sub"]) {                    
        //                    NSLog(@"Sub");
        [p sub:[chunks objectAtIndex:1]];
    }    
}


-(void)runCycle {
    newPrograms = [[CCArray arrayWithCapacity:300] retain];
    
    Program* p;
    
    CCARRAY_FOREACH(programs, p) {   
        
        if (p && p.e > 0) {
            
            p.age = p.age+1;
            [p useEnergy];
        
            for (NSString *line in p.code) {
                NSArray *chunks = [line componentsSeparatedByString:@"|"];
                
//                NSLog(@"%@", line);
                
                if([[chunks objectAtIndex:0] isEqualToString:@"if"]) {
                    NSArray *ifChunks = [line componentsSeparatedByString:@")"];
                    NSString *condition = [[[ifChunks objectAtIndex:0] componentsSeparatedByString:@"|"] objectAtIndex:1];
                    NSString *instruction = [[line componentsSeparatedByString:@")"] objectAtIndex:1];
                    
//                    NSLog(@"if: %@ then %@", condition, instruction);
                    
                    //                                                 @"if|=|*",
//                    
//                    
//                    
//                    NSArray *operators = [NSArray arrayWithObjects:@"==", @">=", @"<=", @">", @"<", @"!=", nil];
//                    return([NSString stringWithFormat:@"%@ %@ %@", [self generateRegisterOrValue], [operators objectAtIndex:arc4random() % [operators count]], [self generateRegisterOrValue]]);
                    
                    
                    NSArray *cChunks = [condition componentsSeparatedByString:@" "];
                    
                    
//                    NSLog(@"Cond: %i %@ %i", [p getValue:[cChunks objectAtIndex:0]], [cChunks objectAtIndex:1],[p getValue:[cChunks objectAtIndex:2]]);
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"=="]) {
//                        NSLog(@"==");
                        if ([p getValue:[cChunks objectAtIndex:0]] == [p getValue:[cChunks objectAtIndex:2]]) {
//                            NSLog(@"RUNNING");                            
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@">="]) {
//                        NSLog(@">=");                        
                        if ([p getValue:[cChunks objectAtIndex:0]] >= [p getValue:[cChunks objectAtIndex:2]]) {
//                            NSLog(@"RUNNING");                            
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"<="]) {
//                        NSLog(@"<=");                        
                        if ([p getValue:[cChunks objectAtIndex:0]] <= [p getValue:[cChunks objectAtIndex:2]]) {
//                            NSLog(@"RUNNING");                            
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@">"]) {
//                        NSLog(@">");                        
                        if ([p getValue:[cChunks objectAtIndex:0]] > [p getValue:[cChunks objectAtIndex:2]]) {
//                            NSLog(@"RUNNING");                            
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"<"]) {
//                        NSLog(@"<");                        
                        if ([p getValue:[cChunks objectAtIndex:0]] < [p getValue:[cChunks objectAtIndex:2]]) {
//                            NSLog(@"RUNNING");                            
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"!="]) {
//                        NSLog(@"!=");                        
                        if ([p getValue:[cChunks objectAtIndex:0]] != [p getValue:[cChunks objectAtIndex:2]]) {
//                            NSLog(@"RUNNING");                            
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                        
                    
//                    [self runInstructionForProgram:p chunks:chunks];
                } else {
                    if (p.e > 0)
                        [self runInstructionForProgram:p chunks:chunks];
                }
                
//                NSLog(@"%@ (%i,%i): a:%i, b:%i, c:%i, d:%i e:%i", p.name, p.x, p.y, p.a, p.b, p.c, p.d, p.e);
                
            } // line in p.code
            
            if (p.e < 0)
                p.e = 0;
            
        } else { // p.e > 0
//            NSLog(@"%@ died at %i", p.name, p.age);
        }
    }
    
//    NSLog(@"NEW PROGRAMS: %@", newPrograms);
    
        for (Program *p in newPrograms) {
            [programs addObject:p];
        }
  

    
    CCARRAY_FOREACH(programs, p) {   
        
        if (p && p.e <= 0) {
            [programs removeObject:p];
        }
    }
    
        
}

@end



//INSTRUCTIONS = [
//                'move|*',     x
//                'look|*',     x
//                'deposit',    x
//                'add|r',
//                'sub|r',
//                'if|=|*'
//                ]
//
//REGISTERS = ['a','b','c','d','e']