//
//  FISIngredientStore.h
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FISIngredient;
@protocol FISIngredientStoreDelegate <NSObject>
- (void)ingredientListUpdated;
@end

@interface FISIngredientStore : NSObject
@property(nonatomic, readonly) NSArray *ingredientList;
@property(weak, nonatomic) id <FISIngredientStoreDelegate> delegate;
+ (instancetype)sharedStore;
- (void)addIngredient:(FISIngredient *)ingredient;
- (void)refreshIngredientList;
@end
