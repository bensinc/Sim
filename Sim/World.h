//
//  World.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import <Foundation/Foundation.h>
#import "Program.h"

@interface World : NSObject {
    int world[100][100];
    id programsArray[1000];
    
    int freeSpot;
    int programsSize;
    
    NSMutableArray *programs;
    NSMutableArray *newPrograms;
    
    int programCount;
    int resourceCount;
}

@property (nonatomic, strong) NSArray *programs;

@property (nonatomic, assign) int programCount;
@property (nonatomic, assign) int resourceCount;

@property (nonatomic, assign) int programsSize;

-(void)generateWorld;

-(int)objectAtX:(int)x Y:(int)y;

-(void)runCycle;

-(void)reproduce:(Program*)p with:(Program*)op;

-(Program*)getProgram:(int)i;

@end
