//
//  Program.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import <Foundation/Foundation.h>
#import "Instruction.h"

@interface Program : NSObject {
    NSString *name;
    int age;
    int x, y;
    int resources;    
    int a, b, c, d, e; // Registers    
    NSMutableArray *code;    
}

@property (nonatomic, retain) NSMutableArray *code;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int resources;
@property (nonatomic, assign) int a;
@property (nonatomic, assign) int b;
@property (nonatomic, assign) int c;
@property (nonatomic, assign) int d;
@property (nonatomic, assign) int e;

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;


-(NSString*)generateInstruction:(BOOL)allowIf;
-(void)generateProgram;

@end
