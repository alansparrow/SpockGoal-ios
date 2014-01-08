//
//  ASGoal.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASGoal.h"
#import "ASRecord.h"


//#define WSLog(...) NSLog(__VA_ARGS__)
#define WSLog(...) do {} while(0)

@implementation ASGoal

@dynamic createdDate;
@dynamic everydayFinishAt;
@dynamic everydayStartAt;
@dynamic friday;
@dynamic monday;
@dynamic orderingValue;
@dynamic remindMe;
@dynamic saturday;
@dynamic sunday;
@dynamic thursday;
@dynamic title;
@dynamic tuesday;
@dynamic wednesday;
@dynamic records;

- (float)accumulatedHours
{
    float resultFloat = 0.0;
    NSArray *tmpRecords = [[self records] allObjects];
    ASRecord *record = nil;
    
    for (int i = 0; i < [tmpRecords count]; i++) {
        record = [tmpRecords objectAtIndex:i];
        WSLog(@"%f", [record duration]);
        resultFloat += [record duration];
    }
    
    return resultFloat;
}

@end
