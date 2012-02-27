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
}

@property (nonatomic, retain) NSMutableArray *programs;

-(void)generateWorld;

-(int)objectAtX:(int)x Y:(int)y;

@end
