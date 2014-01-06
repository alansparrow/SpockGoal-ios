//
//  ASRecord.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ASGoal;

@interface ASRecord : NSManagedObject

@property (nonatomic) int32_t realStartTime;
@property (nonatomic) int32_t realFinishTime;
@property (nonatomic, retain) NSString * quality;
@property (nonatomic, retain) NSString * note;
@property (nonatomic) int32_t duration;
@property (nonatomic, retain) NSString * createdDate;
@property (nonatomic, retain) ASGoal *goal;

@end
