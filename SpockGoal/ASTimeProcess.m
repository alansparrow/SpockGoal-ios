//
//  ASTimeProcess.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASTimeProcess.h"
#import "ASRecord.h"
#import "ASGoal.h"

@implementation ASTimeProcess

- (int)timePointToInt:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    int resultInt = hour*60 + minute;
    NSLog(@"%d : %d", hour, minute);
    
    return resultInt;
}

- (NSString *)dateToString:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSString *resultString = [NSString stringWithFormat:@"%d.%d.%d", day, month, year];
    NSLog(@"%d %d %d", day, month, year);
    
    return resultString;
}

- (float)durationFrom:(NSDate *)startPoint To:(NSDate *)finishPoint
{
    float resultFloat = 0.0;
    
    NSInteger timeInterval = [finishPoint timeIntervalSinceDate:startPoint];
    resultFloat = timeInterval / (3600.0); // calculate how many hours
    
    return resultFloat;
}

- (NSInteger)weekdayFromDate:(NSDate *)date // 1-7
{
    NSInteger resultInt = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    resultInt = [components weekday];
    
    return resultInt;
}

- (NSInteger)dayFromDate:(NSDate *)date // 1-31
{
    NSInteger resultInt = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    
    resultInt = [components day];
    
    return resultInt;
}

- (NSInteger)monthFromDate:(NSDate *)date // 1-12
{
    NSInteger resultInt = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    resultInt = [components month];
    
    return resultInt;
}

- (NSInteger)yearFromDate:(NSDate *)date
{
    NSInteger resultInt = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    
    resultInt = [components year];
    
    return resultInt;
}

- (NSInteger)hourFromDate:(NSDate *)date // 0-23
{
    NSInteger resultInt = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    resultInt = [components hour];
    
    return resultInt;
}

- (NSInteger)minuteFromDate:(NSDate *)date // 0-59
{
    NSInteger resultInt = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSWeekdayCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSYearCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSMinuteCalendarUnit)
                                               fromDate:date];
    resultInt = [components minute];
    
    return resultInt;
}

- (float)accuracyOf:(ASRecord *)record accordingTo:(ASGoal *)goal
{
    float resultFloat = 0.0;
    
    NSDate *rd1 = [self dateFromTimeInterval:[record realStartAt]];
    NSDate *rd2 = [self dateFromTimeInterval:[record realFinishAt]];
    NSInteger realStartPoint = [self timePointToInt:rd1];
    NSInteger realFinishPoint = [self timePointToInt:rd2];
    NSInteger goalStartPoint = [goal everydayStartAt];
    NSInteger goalFinishPoint = [goal everydayFinishAt];
    
    if ([self dayFromDate:rd2] != [self dayFromDate:rd1]) {
        realFinishPoint = 23*60+59; // last of the day
    }
    
    if (realStartPoint <= goalStartPoint && realFinishPoint >= goalFinishPoint) {
        resultFloat = 1.0; // 100%
        return resultFloat;
    } else if (realStartPoint >=goalStartPoint && realFinishPoint <= goalFinishPoint) {
        resultFloat = (realFinishPoint - realStartPoint) / (goalFinishPoint - goalStartPoint);
        return resultFloat;
    } else if ((realStartPoint >= goalStartPoint && realStartPoint <= goalFinishPoint) &&
               realFinishPoint > goalFinishPoint) {
        resultFloat = (goalFinishPoint - realStartPoint) / (goalFinishPoint - goalStartPoint);
        return resultFloat;
    } else if ((realFinishPoint >= goalStartPoint && realFinishPoint <= goalFinishPoint) &&
               realStartPoint < goalStartPoint) {
        resultFloat = (realFinishPoint - goalStartPoint) / (goalFinishPoint - goalStartPoint);
        return resultFloat;
    }
    
    return resultFloat; // 0 %
}


- (NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval
{
    NSDate *resultDate = nil;
    
    resultDate = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    
    return resultDate;
}

@end
