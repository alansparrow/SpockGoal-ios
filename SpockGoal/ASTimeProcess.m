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

- (NSDate *)stringToDate:(NSString *)str
{
    NSDate *resultDate = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    resultDate = [dateFormatter dateFromString:str];
    
    return resultDate;
}

- (NSString *)timeIntervalToString:(NSTimeInterval)timeInterval;
{
    NSString *resultString = nil;
    
    NSDate *date = [self dateFromTimeInterval:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];

    resultString = [dateFormatter stringFromDate:date];
    
    return resultString;
}

- (NSString *)intToTimePoint:(NSInteger)intValue
{
    NSString *resultString = nil;
    int hour = intValue / 60;
    int minute = intValue % 60;
    resultString = [NSString stringWithFormat:@"%2d:%2d", hour, minute];
    
    return resultString;
}

- (NSString *)dateToString:(NSDate *)date
{
    /*
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
     */
    
    NSString *resultString = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    resultString = [dateFormatter stringFromDate:date];
    
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

- (NSInteger)timePointToInt:(NSDate *)date
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
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    resultInt = hour*60+minute;
    
    return resultInt;
}

- (float)accuracyOf:(ASRecord *)record accordingTo:(ASGoal *)goal
{
    float resultFloat = 0.0;
    
    NSDate *rd1 = [self dateFromTimeInterval:[record realStartAt]];
    NSDate *rd2 = [self dateFromTimeInterval:[record realFinishAt]];
    NSDate *gd1 = [self dateFromTimeInterval:[goal everydayStartAt]];
    NSDate *gd2 = [self dateFromTimeInterval:[goal everydayFinishAt]];
    
    NSInteger realStartPoint = [self timePointToInt:rd1];
    NSInteger realFinishPoint = [self timePointToInt:rd2];
    NSInteger goalStartPoint = [self timePointToInt:gd1];
    NSInteger goalFinishPoint = [self timePointToInt:gd2];
    
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

- (NSString *)timeStringFromTimeInterval:(NSTimeInterval)timeInterval
{
    NSString *resultString = nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    resultString = [dateFormatter
                    stringFromDate:[NSDate
                                    dateWithTimeIntervalSinceReferenceDate:timeInterval]];
    
    return resultString;
}

- (NSDate *)setAlarmTimeToHour:(NSInteger)hour andToMinute:(NSInteger)minute
{
    NSDate *resultDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSIntegerMax fromDate:[NSDate date]];
    [components setHour:hour];
    [components setMinute:minute];
    
    resultDate = [calendar dateFromComponents:components];
    
    return resultDate;
}

- (NSString *)goalIDString:(NSTimeInterval)createdDateOfGoal
{
    NSString *resultString = nil;
    
    resultString = [NSString stringWithFormat:@"%f", createdDateOfGoal];
    
    return resultString;
}
- (NSString *)alarmIDString:(NSTimeInterval)createdDateOfGoal forWeekday:(NSInteger)weekday
{
    NSString *resultString = nil;
    
    resultString = [NSString stringWithFormat:@"%f%d", createdDateOfGoal, weekday];
    
    return resultString;
}

- (void)removeAlarmForGoal:(ASGoal *)g
{
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i = 0; i < [eventArray count]; i++) {
        UILocalNotification *alarm = [eventArray objectAtIndex:i];
        NSDictionary *userInfo = [alarm userInfo];
        
        if ([[userInfo valueForKey:@"goal_id"] isEqualToString:[timeProcess goalIDString:[g createdDate]]]) {
            [app cancelLocalNotification:alarm];
        }
    }
}

- (void)setAlarmForGoal:(ASGoal *)g
{
    // 1st object is ignored because we use index to define weekday
    // 1 is sunday, 2 is monday..
    NSArray *weekdays = [NSArray arrayWithObjects:[NSDate date],
                         [NSNumber numberWithBool:[g sunday]], [NSNumber numberWithBool:[g monday]],
                         [NSNumber numberWithBool:[g tuesday]], [NSNumber numberWithBool:[g wednesday]],
                         [NSNumber numberWithBool:[g thursday]], [NSNumber numberWithBool:[g friday]],
                         [NSNumber numberWithBool:[g saturday]],
                         nil];
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    
    // remove all of this goal's alarm
    // prepare for new setting
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i = 0; i < [eventArray count]; i++) {
        UILocalNotification *alarm = [eventArray objectAtIndex:i];
        NSDictionary *userInfo = [alarm userInfo];
        
        if ([[userInfo valueForKey:@"goal_id"] isEqualToString:[timeProcess goalIDString:[g createdDate]]]) {
            [app cancelLocalNotification:alarm];
        }
    }
    
    
    
    if ([g remindMe]) {
        
        NSInteger alarmHour = [timeProcess
                               hourFromDate:
                               [NSDate dateWithTimeIntervalSinceReferenceDate:[g everydayStartAt]]];
        NSInteger alarmMinute = [timeProcess
                                 minuteFromDate:
                                 [NSDate dateWithTimeIntervalSinceReferenceDate:[g everydayStartAt]]];
        
        NSDate *baseTime = [timeProcess
                            setAlarmTimeToHour:alarmHour andToMinute:alarmMinute];
        
        NSInteger oneDayInterval = 24*60*60;
        
        for (int i = 0; i < 7; i++) {
            double timeInterval = i * oneDayInterval;
            NSDate *alarmTime = [baseTime dateByAddingTimeInterval:timeInterval];
            NSInteger weekday = [timeProcess weekdayFromDate:alarmTime];
            if ([[weekdays objectAtIndex:weekday] boolValue] == YES) {
                UILocalNotification *alarm = [[UILocalNotification alloc] init];
                [alarm setFireDate:alarmTime];
                [alarm setRepeatInterval:NSWeekCalendarUnit];
                
                NSArray *keys = [NSArray arrayWithObjects:@"goal_id",
                                 @"alarm_id",
                                 @"message", nil];
                NSArray *values = [NSArray arrayWithObjects:[timeProcess goalIDString:[g createdDate]],
                                   [timeProcess alarmIDString:[g createdDate] forWeekday:weekday],
                                   [NSString stringWithFormat:@"It's time to do some %@", [g title]]
                                   , nil];
                NSDictionary *userInfo = [[NSDictionary alloc]
                                          initWithObjects:values forKeys:keys];
                [alarm setUserInfo:userInfo];
                [alarm setAlertBody:[NSString stringWithFormat:@"It's time to do some %@",
                                     [g title]]];
                [alarm setSoundName:@"Illuminate.m4r"];
                
                [[UIApplication sharedApplication] scheduleLocalNotification:alarm];
            }
        }
    }

}

@end
