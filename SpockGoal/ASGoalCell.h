//
//  ASGoalCell.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASGoalCell : UITableViewCell
{
    __weak IBOutlet UILabel *goalTitleLabel;
    __weak IBOutlet UILabel *accumulatedHourLabel;
    __weak IBOutlet UIImageView *iconImage;
    __weak IBOutlet UILabel *lastTimeLabel;
    __weak IBOutlet UILabel *mondayLabel;
    __weak IBOutlet UILabel *tuesdayLabel;
    __weak IBOutlet UILabel *wednesdayLabel;
    __weak IBOutlet UILabel *thursdayLabel;
    __weak IBOutlet UILabel *fridayLabel;
    __weak IBOutlet UILabel *saturdayLabel;
    __weak IBOutlet UILabel *sundayLabel;
    __weak IBOutlet UILabel *scheduleLabel;
    __weak IBOutlet UIImageView *alarmIcon;
}

@property (weak, nonatomic) IBOutlet UILabel *goalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accumulatedHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mondayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *thursdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fridayLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *sundayLabel;
@property (weak, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alarmIcon;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
