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


-(id)init {

    
    if (self = [super init])
    {
        self.a = 0;
        self.b = 0;
        self.c = 0;
        self.d = 0;
        self.e = 30;
        self.age = 0;
        self.x = 0;
        self.y = 0;
    }
    return self;    
    
    
}

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
        return([NSString stringWithFormat:@"if|%@)%@", [self generateCondition], [self generateInstruction:NO]]);
    } else if ([chunks count] == 2) {                
        return([NSString stringWithFormat:@"%@|%@", [chunks objectAtIndex:0], [self generateParameter:[chunks objectAtIndex:1]]]);
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


-(int)getValue:(NSString*)v {
    if ([v intValue] > 0) {
        return([v intValue]);
    } else {
        if ([v isEqualToString:@"a"])
            return(a);
        if ([v isEqualToString:@"b"])
            return(b);
        if ([v isEqualToString:@"c"])
            return(c);
        if ([v isEqualToString:@"d"])
            return(d);
        if ([v isEqualToString:@"e"])
            return(e);        
    }
    return(-1);
}


-(void)add:(NSString*)r {
    if ([r isEqualToString:@"a"]) {
        self.a++;
        if (self.a > 8)
            self.a = 0;
    }
    if ([r isEqualToString:@"b"]) {
        self.b++;
        if (self.b > 8)
            self.b = 0;        
    }
    if ([r isEqualToString:@"c"]) {
        self.c++;
        if (self.c > 8)
            self.c = 0;
    }
    if ([r isEqualToString:@"d"]) {
        self.d++;
        if (self.d > 8)
            self.d = 0;        
    }
}

-(void)sub:(NSString*)r {
    if ([r isEqualToString:@"a"]) {
        self.a--;
        if (self.a < 0)
            self.a = 0;
    }
    if ([r isEqualToString:@"b"]) {
        self.b--;
        if (self.b < 0)
            self.b = 0;        
    }
    if ([r isEqualToString:@"c"]) {
        self.c--;
        if (self.c < 0)
            self.c = 0;
    }
    if ([r isEqualToString:@"d"]) {
        self.d--;
        if (self.d < 0)
            self.d = 0;        
    }
}



-(void)useEnergy {
    e--;
    if (e < 0)
        e = 0;
}

-(void)move:(NSString*)v {
    
    
//    NSLog(@"MOVE: %@", v);
    switch([self getValue:v]) {
        case 1:
            self.x--;
            self.y--;
        case 2:
            self.x--;
        case 3:
            self.x--;
            self.y++;
        case 4:
            self.x++;
        case 5:
            self.x++;
            self.y++;
        case 6:
            self.y++;
        case 7:
            self.x--;
            self.y++;
        case 8:
            self.y--;
            
    }
    
    if (self.x > 100)
        self.x = 0;
    
    if (self.x < 0)
        self.x = 100;
    
    if (self.y > 100)
        self.y = 0;
    
    if (self.y < 0)
        self.y = 100;
    
    
}




@end
