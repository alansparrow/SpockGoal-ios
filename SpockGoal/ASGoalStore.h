//
//  ASGoalStore.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ASGoal;
@class ASRecord;

@interface ASGoalStore : NSObject

{
    NSMutableArray *allGoals;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

// Notice that this is a class method and prefixed with a + instead of a -
+ (ASGoalStore *)sharedStore;

- (NSArray *)allGoals;
- (ASGoal *)createGoal;
- (ASGoal *)createRandomGoal;
- (ASRecord *)createRandomRecordForGoal:(ASGoal *)goal;

@end
