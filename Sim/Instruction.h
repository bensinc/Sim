//
//  Instruction.h
//  Sim
//
//  Created by Ben Sinclair on 2/27/12.
//  Copyright (c) 2012 Industrial Parker, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

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


@interface Instruction : NSObject {
    NSString *opcode;
    NSMutableArray *parameters;
}

@property (nonatomic, retain) NSString* opcode;
@property (nonatomic, retain) NSMutableArray* parameters;

@end
