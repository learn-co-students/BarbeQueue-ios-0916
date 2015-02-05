//
//  FISIngredient.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISIngredient.h"

@implementation FISIngredient

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        _pendingWrite = YES;
    }
    return self;
}

@end
