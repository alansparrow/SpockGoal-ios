//
//  ASRecordCell.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/9/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASRecordCell.h"

@implementation ASRecordCell

@synthesize dateLabel, qualityLabel, timeLabel, durationLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
