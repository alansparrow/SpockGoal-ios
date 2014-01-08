//
//  ASGoalCopy.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASGoalCopy.h"
#import "ASGoal.h"

@implementation ASGoalCopy

@synthesize title, orderingValue, remindMe, monday, everydayFinishAt,
everydayStartAt, createdDate, friday, saturday, sunday, thursday,
tuesday, wednesday;

- (id)initWith:(ASGoal *)g
{
    self = [super init];
    
    if (self) {
        [self setTitle:[g title]];
        [self setCreatedDate:[g createdDate]];
        [self setEverydayStartAt:[g everydayStartAt]];
        [self setEverydayFinishAt:[g everydayFinishAt]];
        [self setMonday:[g monday]];
        [self setTuesday:[g tuesday]];
        [self setWednesday:[g wednesday]];
        [self setThursday:[g thursday]];
        [self setFriday:[g friday]];
        [self setSaturday:[g saturday]];
        [self setSunday:[g sunday]];
        [self setRemindMe:[g remindMe]];
        [self setOrderingValue:[g orderingValue]];
    }
    
    return self;
}

- (void)copyWith:(ASGoal *)g
{
    [self setTitle:[g title]];
    [self setCreatedDate:[g createdDate]];
    [self setEverydayStartAt:[g everydayStartAt]];
    [self setEverydayFinishAt:[g everydayFinishAt]];
    [self setMonday:[g monday]];
    [self setTuesday:[g tuesday]];
    [self setWednesday:[g wednesday]];
    [self setThursday:[g thursday]];
    [self setFriday:[g friday]];
    [self setSaturday:[g saturday]];
    [self setSunday:[g sunday]];
    [self setRemindMe:[g remindMe]];
    [self setOrderingValue:[g orderingValue]];
}

@end
