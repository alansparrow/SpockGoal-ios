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
}

@property (weak, nonatomic) IBOutlet UILabel *goalTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *accumulatedHourLabel;

@end
