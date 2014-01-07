//
//  ASGoal.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASGoal.h"
#import "ASRecord.h"


@implementation ASGoal

@dynamic title;
@dynamic createdDate;
@dynamic everydayFinishAt;
@dynamic everydayStartAt;
@dynamic remindMe;
@dynamic monday;
@dynamic tuesday;
@dynamic wednesday;
@dynamic thursday;
@dynamic friday;
@dynamic saturday;
@dynamic sunday;
@dynamic orderingValue;
@dynamic records;

- (float)accumulatedHours
{
    float resultFloat = 0.0;
    NSArray *tmpRecords = [[self records] allObjects];
    ASRecord *record = nil;
    
    for (int i = 0; i < [tmpRecords count]; i++) {
        record = [tmpRecords objectAtIndex:i];
        resultFloat += [record duration];
    }
    
    return resultFloat;
}

@end
