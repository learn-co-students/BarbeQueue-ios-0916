//
//  FISAPIClient.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import "FISAPIClient.h"

#import "FISRequestQueue.h"
#import "FISIngredient.h"
@interface FISAPIClient () <NSURLSessionTaskDelegate>
@property(nonatomic) NSURLSession *urlSession;
@property(nonatomic) FISRequestQueue *ingredientQueue;
@property(nonatomic) NSMutableArray *requestQueues;
@end
@implementation FISAPIClient

- (instancetype)init {
    if (self = [super init]) {
        _urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
        _ingredientQueue = [[FISRequestQueue alloc] init];
        _requestQueues = [[NSMutableArray alloc] initWithObjects:[[FISRequestQueue alloc] init], nil];
    }
    return self;
}

- (void)addNewIngredient:(FISIngredient *)ingredient {
    [self.ingredientQueue enqueue:ingredient];
    [self executeIngredientQueue];
}

- (void)refresh {
    [self executeIngredientQueue];
}

#pragma mark - Private

- (NSURLSessionDataTask *)createURLTaskWithIngredient:(FISIngredient *)ingredient {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://divebarny.com"] cachePolicy:0 timeoutInterval:3];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *newIngredientTask = [self.urlSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Calling failedRequestWith: with %@", ingredient.name);
            [self failedRequestWith:ingredient];
        } else {
            [self succeededRequestWith:ingredient];
        }
    }];
    return newIngredientTask;
}


- (void)succeededRequestWith:(FISIngredient *)ingredient {
    NSLog(@"Request Succeeded with %@", ingredient.name);
    [self.delegate addIngredientResponseReceivedWithIngredient:ingredient];
    [self.ingredientQueue dequeue];
    [self executeIngredientQueue];
}

- (void)failedRequestWith:(FISIngredient *)ingredient {
    NSLog(@"Request Failed with %@", ingredient.name);
}

- (void)executeIngredientQueue {
    FISIngredient *firstQueuedIngredient = [self.ingredientQueue peek];
    if (firstQueuedIngredient) {
        NSURLSessionDataTask *task = [self createURLTaskWithIngredient:firstQueuedIngredient];
        [task resume];
    }
}

@end
