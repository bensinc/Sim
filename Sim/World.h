//
//  World.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import <Foundation/Foundation.h>
#import "Program.h"

@interface World : NSObject {
    id world[100][100];
    NSMutableArray *programs;
}

@property (nonatomic, retain) NSMutableArray *programs;

-(void)generateWorld;

@end
