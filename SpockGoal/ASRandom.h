//
//  ASRandom.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASRecord;

@interface ASRandom : NSObject


- (NSString *)randomGoalTitle;
- (float)randomAccumulatedHours;
- (NSDate *)randomTimePoint1;
- (NSDate *)randomTimePoint2;
- (BOOL)randomBoolean;
- (NSDate *)randomDate;
- (void)initRandomValueFor:(ASRecord *)record;
- (NSString *)randomQuality;
- (float)randomDuration;
- (NSString *)randomNote;
@end
