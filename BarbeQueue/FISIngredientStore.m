//
//  FISIngredientStore.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISIngredientStore.h"

#import "FISIngredient.h"
#import "FISAPIClient.h"
@interface FISIngredientStore () <FISAPIClientDelegate>
@property(nonatomic, readwrite) NSArray *ingredientList;
@property(nonatomic) FISAPIClient *apiClient;
@end
@implementation FISIngredientStore

+(FISIngredientStore *)sharedStore
{
    static FISIngredientStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISIngredientStore alloc] init];
    });
    return _sharedDataStore;
}

- (instancetype)init {
    if (self = [super init]) {
        _ingredientList = @[];
        _apiClient = [[FISAPIClient alloc] init];
        _apiClient.delegate = self;
    }
    return self;
}

- (void)addIngredient:(FISIngredient *)ingredient {
    if (ingredient) {
        ingredient.pendingWrite = YES;
        [self addIngredientToList:ingredient];
        [self.apiClient addNewIngredient:ingredient];
    }
}

- (void)refreshIngredientList {
    [self.apiClient refresh];
}

#pragma mark - Private
- (void)addIngredientToList:(FISIngredient *)ingredient {
    self.ingredientList = [@[ingredient] arrayByAddingObjectsFromArray:self.ingredientList];
    [self.delegate ingredientListUpdated];
}

- (void)removeIngredientFromList:(FISIngredient *)ingredient {
    NSMutableArray *mutableList = [self.ingredientList mutableCopy];
    [mutableList removeObject:ingredient];
    self.ingredientList = [mutableList copy];
    [self.delegate ingredientListUpdated];
}

#pragma mark - APIClient Delegate

- (void)addIngredientResponseReceivedWithIngredient:(FISIngredient *)ingredient {
    ingredient.pendingWrite = NO;
    [self.delegate ingredientListUpdated];
}

- (void)deleteIngredientResponseReceivedWithIngredient:(FISIngredient *)ingredient {
    [self removeIngredientFromList:ingredient];
    [self.delegate ingredientListUpdated];
}

@end
