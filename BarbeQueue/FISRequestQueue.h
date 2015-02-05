//
//  FISRequestQueue.h
//  BarbeQueue
//
//  Created by Chris Gonzales on 1/29/15.
//  Copyright (c) 2015 The Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISRequestQueue : NSObject
- (BOOL)isEmpty;
- (void)enqueue:(id)anItem;
- (id)dequeue;
- (NSUInteger)size;
- (id)peek;
@end
