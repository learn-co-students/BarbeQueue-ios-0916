//
//  FISRequestQueueSpec.m
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright 2015 The Flatiron School. All rights reserved.
//

#import "Specta.h"
#import "FISRequestQueue.h"
#define EXP_SHORTHAND
#import <Expecta.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"


SpecBegin(FISRequestQueue)

describe(@"FISRequestQueue", ^{
    __block FISRequestQueue *queue = [[FISRequestQueue alloc] init];
    __block NSMutableArray *queueBackingArray = [queue performSelector:@selector(queue)];
    
    beforeEach(^{
        [queueBackingArray removeAllObjects];
    });
    
    describe(@"checking if the queue is empty", ^{
        context(@"when the queue is empty", ^{
            it(@"should return true",^{
                FISRequestQueue *emptyQueue = [[FISRequestQueue alloc] init];
                expect(emptyQueue.isEmpty).to.beTruthy();
            });
        });
        
        context(@"when the queue is not empty", ^{
            it(@"should return false",^{
                [queueBackingArray addObject:@1];
                expect(queue.isEmpty).to.beFalsy();
            });
        });
    });
    
    describe(@"adding an object to the queue", ^{
        it(@"should add an object to the queue",^{
            [queue enqueue:@2];
            expect(queueBackingArray.count).to.equal(1);
        });
    });
    
    describe(@"removing an object from the queue", ^{
        context(@"when there are items in the queue", ^{
            beforeEach(^{
                [queueBackingArray addObjectsFromArray:@[@3, @4]];
            });
            
            it(@"should remove the first item in the queue",^{
                [queue dequeue];
                expect([queueBackingArray indexOfObject:@3]).to.equal(NSNotFound);
            });
            
            it(@"should return the dequeued object",^{
                NSNumber *dequeuedObject = [queue dequeue];
                expect(dequeuedObject).to.equal(@3);
            });
        });
        
        context(@"when there are no items in the queue", ^{
            it(@"should return nil",^{
                FISRequestQueue *emptyQueue = [[FISRequestQueue alloc] init];
                expect([emptyQueue dequeue]).to.beNil();
            });
        });
        
    });
    
    describe(@"asking for the number if items in the queue", ^{
        context(@"when there are items in the queue", ^{
            it(@"should return the number of items",^{
                [queueBackingArray addObjectsFromArray:@[@5,@6,@7]];
                expect(queue.size).to.equal(3);
            });
        });
        
        context(@"when there are no items in the queue", ^{
            it(@"should return 0",^{
                FISRequestQueue *emptyQueue = [[FISRequestQueue alloc] init];
                expect(emptyQueue.size).to.equal(0);
            });
        });
    });
    
    describe(@"getting the next object in the queue", ^{
        context(@"when there are items in the queue", ^{
            beforeEach(^{
                [queueBackingArray addObjectsFromArray:@[@8, @9]];
            });
            
            it(@"should return the next item in the queue",^{
                NSNumber *peekedNumber = [queue peek];
                expect(peekedNumber).to.equal(@8);
            });
            
            it(@"should not change the queue",^{
                NSArray *itemsBeforePeek = [queueBackingArray copy];
                [queue peek];
                expect(queueBackingArray).to.equal(itemsBeforePeek);
            });
        });
        
        context(@"when there are no items in the queue", ^{
            it(@"should return nil",^{
                FISRequestQueue *emptyQueue = [[FISRequestQueue alloc] init];
                expect([emptyQueue peek]).to.beNil();
            });
        });
    });
});

SpecEnd
#pragma clang diagnostic pop
