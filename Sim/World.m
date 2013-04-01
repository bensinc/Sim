//
//  World.m
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import "World.h"

#define ENERGY_VALUE 5

@implementation World

@synthesize programs, programCount, resourceCount, programsSize;

-(void)generateWorld
{
    programs = [[NSMutableArray arrayWithCapacity:1] retain];
    
    for (int i = 0; i < programCount; i++)
    {
        [programs addObject:[[Program alloc] init:i]];
    }
    
    programsSize = programCount;
    
    for (int i = 0; i < resourceCount; i++) {
        world[arc4random() % 100][arc4random() % 100] = 1;
    }
    
}

-(Program*)getProgram:(int)i
{
    if (programsArray[i])
        return programsArray[i];
    else
        return nil;
}

-(int)objectAtX:(int)x Y:(int)y
{
    return(world[x][y]);
}

-(void)reproduce:(Program*)p with:(Program*)op
{
    Program *newP = [[Program alloc] init:programCount++];    
    for (int i = 0; i < 10; i++) {
        id object = [p.code objectAtIndex:i];
        if ([object isEqualToString:[op.code objectAtIndex:i]])
        {
            [newP.code replaceObjectAtIndex:i withObject:object];
        }
    }   
    [newPrograms addObject:newP];
}


-(void)runInstructionForProgram:(Program*)p chunks:(NSArray*)chunks
{
    int px = p.x;
    int py = p.y;
    
    if([[chunks objectAtIndex:0] isEqualToString:@"move"])
    {
        [p move:[chunks objectAtIndex:1]];

        if ([self objectAtX:px Y:py] == 1) {
            p.e = p.e + ENERGY_VALUE;
            world[px][py] = 0;
        }
        
        for (Program *op in programs)
        {
            if (op.x == px)
            {
                if (op.y == py)
                {
                    if (op != p)
                    {
                        if (op.e > 0)
                        {
                            [self reproduce:p with:op];
                        }
                    }
                }
            }
        }        
       
    }
    
    if([[chunks objectAtIndex:0] isEqualToString:@"deposit"])
    {
        if ([self objectAtX:px Y:py] == 0)
        {
            p.e = p.e - ENERGY_VALUE;
            world[px][py] = 1;                 
        }
    }                
    
    if([[chunks objectAtIndex:0] isEqualToString:@"look"])
    {
        int v = [p getValue:[chunks objectAtIndex:1]];
        
        int x = px;
        int y = py;
        
        switch(v)
        {
            case 1:
                x--;
                y--;
                break;
            case 2:
                x--;
                break;
            case 3:
                x--;
                y++;
                break;
            case 4:
                x++;
                break;
            case 5:
                x++;
                y++;
                break;
            case 6:
                y++;
                break;
            case 7:
                x++;
                y--;
                break;
            case 8:
                y--;
                break;
            default:
                break;
        }
        
        if (x > 100)
        {
            x = 0;
        }
        if (x < 0)
        {
            x = 100;
        }
        if (y > 100)
        {
            y = 0;
        }
        if (y < 0)
        {
            y = 100;
        }
        p.a = [self objectAtX:x Y:y];
    }
    
    if([[chunks objectAtIndex:0] isEqualToString:@"add"])
    {
        [p add:[chunks objectAtIndex:1]];
    }
    
    if([[chunks objectAtIndex:0] isEqualToString:@"sub"])
    {
        [p sub:[chunks objectAtIndex:1]];
    }    
}


-(void)runCycle {
    newPrograms = [[NSMutableArray arrayWithCapacity:1] retain];
    for (Program *p in programs)
    {
        if (p.e > 0)
        {
            p.age = p.age+1;
            [p useEnergy];
            for (NSString *line in p.code)
            {
                NSArray *chunks = [line componentsSeparatedByString:@"|"];
                            
                if([[chunks objectAtIndex:0] isEqualToString:@"if"])
                {
                    NSArray *ifChunks = [line componentsSeparatedByString:@")"];
                    NSString *condition = [[[ifChunks objectAtIndex:0] componentsSeparatedByString:@"|"] objectAtIndex:1];
                    NSString *instruction = [[line componentsSeparatedByString:@")"] objectAtIndex:1];
                    NSArray *cChunks = [condition componentsSeparatedByString:@" "];
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"=="])
                    {
                        if ([p getValue:[cChunks objectAtIndex:0]] == [p getValue:[cChunks objectAtIndex:2]])
                        {
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@">="]) {
                        if ([p getValue:[cChunks objectAtIndex:0]] >= [p getValue:[cChunks objectAtIndex:2]])
                        {
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"<="])
                    {
                        if ([p getValue:[cChunks objectAtIndex:0]] <= [p getValue:[cChunks objectAtIndex:2]])
                        {
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@">"])
                    {
                        if ([p getValue:[cChunks objectAtIndex:0]] > [p getValue:[cChunks objectAtIndex:2]])
                        {
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"<"])
                    {
                        if ([p getValue:[cChunks objectAtIndex:0]] < [p getValue:[cChunks objectAtIndex:2]])
                        {
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                    
                    if ([[cChunks objectAtIndex:1] isEqualToString:@"!="])
                    {
                        if ([p getValue:[cChunks objectAtIndex:0]] != [p getValue:[cChunks objectAtIndex:2]])
                        {
                            [self runInstructionForProgram:p chunks:[instruction componentsSeparatedByString:@"|"]];
                        }
                    }                    
                        
                } else {
                    if (p.e > 0)
                        [self runInstructionForProgram:p chunks:chunks];
                }
            } // line in p.code
            
            if (p.e < 0)
                p.e = 0;
        }
    }
    
    for (Program *p in programs)
    {
        if (p.e > 0)
        {
            [newPrograms addObject:p];
        }
    }
    programs = newPrograms;
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