//
//  ASRecord.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ASGoal;

@interface ASRecord : NSManagedObject

@property (nonatomic) double accuracy;
@property (nonatomic) int32_t createdDate;
@property (nonatomic) int32_t createdMonth;
@property (nonatomic) int32_t createdYear;
@property (nonatomic) double duration;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * quality;
@property (nonatomic) NSTimeInterval realFinishAt;
@property (nonatomic) NSTimeInterval realStartAt;
@property (nonatomic, retain) ASGoal *goal;

@end
