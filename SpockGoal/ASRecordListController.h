//
//  ASRecordListController.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/9/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASGoal;

@interface ASRecordListController : UITableViewController

{
    __weak ASGoal *savedGoal;
    NSMutableArray *sortedRecords;
}

@property (nonatomic, copy) void (^dismissBlock)(void);

- (id)initFor:(ASGoal *)goal;

@end
