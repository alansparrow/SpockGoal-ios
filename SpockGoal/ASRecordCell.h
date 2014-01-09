//
//  ASRecordCell.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/9/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASRecordCell : UITableViewCell

{
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UILabel *qualityLabel;
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet UILabel *durationLabel;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *qualityLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@end
