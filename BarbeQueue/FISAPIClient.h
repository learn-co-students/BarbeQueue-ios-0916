//
//  FISAPIClient.h
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FISIngredient;
@protocol FISAPIClientDelegate <NSObject>
- (void)addIngredientResponseReceivedWithIngredient:(FISIngredient *)ingredient;
@end

@interface FISAPIClient : NSObject
@property (weak, nonatomic) id <FISAPIClientDelegate> delegate;
- (void)addNewIngredient:(FISIngredient *)ingredient;
- (void)refresh;
@end
