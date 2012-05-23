//
//  World.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import <Foundation/Foundation.h>
#import "Program.h"
#import "CCArray.h"

@interface World : NSObject {
    int world[100][100];
    id programsArray[1000];
    
    int freeSpot;
    int programsSize;
    
    CCArray *programs;
    CCArray *newPrograms;
    
    int programCount;
    int resourceCount;
}

@property (nonatomic, strong) CCArray *programs;
@property (nonatomic, strong) CCArray *newPrograms;


@property (nonatomic, assign) int programCount;
@property (nonatomic, assign) int resourceCount;

@property (nonatomic, assign) int programsSize;
@property (nonatomic, assign) id programsArray;


-(void)generateWorld;

-(int)objectAtX:(int)x Y:(int)y;

-(void)runCycle;

-(void)reproduce:(Program*)p with:(Program*)op;

-(Program*)getProgram:(int)i;

@end
