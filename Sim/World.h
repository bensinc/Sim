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
    NSMutableArray *programs;
    NSMutableArray *newPrograms;    
    int programCount;
    int resourceCount;
}

@property (nonatomic, strong) NSMutableArray *programs;
@property (nonatomic, strong) NSMutableArray *newPrograms;


@property (nonatomic, assign) int programCount;
@property (nonatomic, assign) int resourceCount;

-(void)generateWorld;

-(int)objectAtX:(int)x Y:(int)y;

-(void)runCycle;

-(void)reproduce:(Program*)p with:(Program*)op;

@end
