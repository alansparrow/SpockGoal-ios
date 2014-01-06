//
//  ASGoalStore.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASGoalStore.h"
#import "ASGoal.h"

@implementation ASGoalStore

+ (ASGoalStore *)sharedStore
{
    static ASGoalStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        allGoals = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allGoals
{
    return allGoals;
}

- (ASGoal *)createGoal
{
    ASGoal *g = [[ASGoal alloc] init];
    [allGoals addObject:g];
    
    return g;
}

@end
