//
//  Program.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import <Foundation/Foundation.h>


@interface Program : NSObject {
    NSString *name;
    int age;
    int x, y;
    int resources;    
    int a, b, c, d, e; // Registers    
    int programId;
    NSMutableArray *code;    
}

@property (nonatomic, strong) NSMutableArray *code;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int resources;
@property (nonatomic, assign) int a;
@property (nonatomic, assign) int b;
@property (nonatomic, assign) int c;
@property (nonatomic, assign) int d;
@property (nonatomic, assign) int e;

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;

@property (nonatomic, assign) int programId;

-(id)init:(int)value withCode:(BOOL)wc;

-(NSString*)generateInstruction:(BOOL)allowIf;
-(void)generateProgram;

-(int)getValue:(NSString*)v;

-(void)move:(NSString*)v;
-(void)useEnergy;

-(void)add:(NSString*)r;
-(void)sub:(NSString*)r;



@end
