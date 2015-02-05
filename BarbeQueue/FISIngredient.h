//
//  FISIngredient.h
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISIngredient : NSObject
@property(nonatomic) NSString *name;
@property(nonatomic) BOOL pendingWrite;
- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;
@end
