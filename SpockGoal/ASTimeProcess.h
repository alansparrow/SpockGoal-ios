//
//  ASTimeProcess.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ASRecord;
@class ASGoal;

@interface ASTimeProcess : NSObject

- (NSDate *)stringToDate:(NSString *)str;
- (int)timePointToInt:(NSDate *)date;
- (NSString *)timeIntervalToString:(NSTimeInterval)timeInterval;
- (NSString *)dateToString:(NSDate *)date;
- (float)durationFrom:(NSDate *)startPoint To:(NSDate *)finishPoint;
- (NSInteger)weekdayFromDate:(NSDate *)date; // 1-7
- (NSInteger)dayFromDate:(NSDate *)date; // 1-31
- (NSInteger)monthFromDate:(NSDate *)date; // 1-12
- (NSInteger)yearFromDate:(NSDate *)date;
- (NSInteger)hourFromDate:(NSDate *)date; // 0-23
- (NSInteger)minuteFromDate:(NSDate *)date; // 0-59
- (float)accuracyOf:(ASRecord *)record accordingTo:(ASGoal *)goal;
- (NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval;
- (NSString *)timeStringFromTimeInterval:(NSTimeInterval)timeInterval;
- (NSDate *)setAlarmTimeToHour:(NSInteger)hour andToMinute:(NSInteger)minute;
- (NSString *)goalIDString:(NSTimeInterval)createdDateOfGoal;
- (NSString *)alarmIDString:(NSTimeInterval)createdDateOfGoal forWeekday:(NSInteger)weekday;
- (void)setAlarmForGoal:(ASGoal *)g;
- (void)removeAlarmForGoal:(ASGoal *)g;
@end
