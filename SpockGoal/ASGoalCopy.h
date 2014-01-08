//
//  ASGoalCopy.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASGoal;

@interface ASGoalCopy : NSObject

@property (nonatomic) NSTimeInterval createdDate;
@property (nonatomic) NSTimeInterval everydayFinishAt;
@property (nonatomic) NSTimeInterval everydayStartAt;
@property (nonatomic) BOOL friday;
@property (nonatomic) BOOL monday;
@property (nonatomic) double orderingValue;
@property (nonatomic) BOOL remindMe;
@property (nonatomic) BOOL saturday;
@property (nonatomic) BOOL sunday;
@property (nonatomic) BOOL thursday;
@property (nonatomic, retain) NSString * title;
@property (nonatomic) BOOL tuesday;
@property (nonatomic) BOOL wednesday;

- (void)copyWith:(ASGoal *)g;
- (id)initWith:(ASGoal *)g;

@end
