//
//  ASGoalStore.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASGoal;

@interface ASGoalStore : NSObject

{
    NSMutableArray *allGoals;
}

// Notice that this is a class method and prefixed with a + instead of a -
+ (ASGoalStore *)sharedStore;

- (NSArray *)allGoals;
- (ASGoal *)createGoal;

@end
