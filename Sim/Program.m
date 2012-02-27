//
//  Program.m
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//

#import "Program.h"

//INSTRUCTIONS = [
//                'move|*',
//                'look|*',
//                'deposit',
//                'add|r',
//                'sub|r',
//                'if|=|*'
//                ]
//
//REGISTERS = ['a','b','c','d','e']


@implementation Program

@synthesize name, code, x, y, age, resources, a, b, c, d, e;

-(NSString*)generateParameter:(NSString*)kind {
    NSArray *registers = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", nil];
    if ([kind isEqualToString:@"r"]) {
        return([registers objectAtIndex:arc4random() % [registers count]]);
    } else {
        if (arc4random() % 2 == 0) {
            return([NSString stringWithFormat:@"%i", (arc4random() % 8)+1]);
        } else {
            return([registers objectAtIndex:arc4random() % [registers count]]);
        }
    }
}

-(NSString*)generateRegisterOrValue {
    NSArray *registers = [NSArray arrayWithObjects:@"a", @"b", @"c", @"d", @"e", nil];
    if (arc4random() % 2 == 0) {
        return([registers objectAtIndex:arc4random() % [registers count]]);
    } else {
        return([NSString stringWithFormat:@"%i", (arc4random() % 8)+1]);
    }    
}

-(NSString*)generateCondition {
    NSArray *operators = [NSArray arrayWithObjects:@"==", @">=", @"<=", @">", @"<", @"!=", nil];
    return([NSString stringWithFormat:@"%@ %@ %@", [self generateRegisterOrValue], [operators objectAtIndex:arc4random() % [operators count]], [self generateRegisterOrValue]]);
}


-(NSString*)generateInstruction:(BOOL)allowIf {
    NSArray *instructions = [NSArray arrayWithObjects:
                             @"move|*",
                             @"look|*",
                             @"deposit",
                             @"add|r",
                             @"sub|r",
                             @"if|=|*",
                             nil];
    
    long r = arc4random() % [instructions count];    
    if (!allowIf) {
        r = arc4random() % ([instructions count]-1);
    }
    
    NSString *instruction = [instructions objectAtIndex:r];
    
    
    NSArray *chunks = [instruction componentsSeparatedByString:@"|"];
        
    
    if ([chunks count] == 3) { // if
        return([NSString stringWithFormat:@"if %@ then %@", [self generateCondition], [self generateInstruction:NO]]);
    } else if ([chunks count] == 2) {                
        return([NSString stringWithFormat:@"%@ %@", [chunks objectAtIndex:0], [self generateParameter:[chunks objectAtIndex:1]]]);
    } else {
        return(instruction);
    }
    
    
}


-(void)generateProgram {
    code = [[NSMutableArray alloc]init];
    for (int i = 0; i < 10; i++) {
        [code addObject:[self generateInstruction:YES]];
    }
}

@end
