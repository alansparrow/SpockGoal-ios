//
//  ASTimerViewController.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/9/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASGoal;
@class ASRecord;

@interface ASTimerViewController : UIViewController <UIActionSheetDelegate>
{
    __weak IBOutlet UILabel *goalTitleLabel;
    __weak IBOutlet UILabel *timerLabel;
    NSDate *start;
    NSDate *current;
    NSTimer *stopWatchTimer;
    __weak ASGoal *savedGoal;
    __weak ASRecord *savedRecord;
}

@property (nonatomic, copy) void (^dismissBlock)(void);

- (id)initFor:(ASGoal *)goal;
- (IBAction)finishButtonClick:(id)sender;
@end
