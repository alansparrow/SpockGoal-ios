//
//  ASMainViewController.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASMainViewController.h"
#import "ASGoalStore.h"
#import "ASGoal.h"
#import "ASGoalCell.h"
#import "ASRandom.h"
#import "ASRecord.h"

@implementation ASMainViewController

- (id)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        for (int i = 0; i < 5; i++) {
            ASGoal *g = [[ASGoalStore sharedStore] createRandomGoal];
            
            for (int j = 0; j < 10; j++) {
                [[ASGoalStore sharedStore] createRandomRecordForGoal:g];
            }
        }
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[ASGoalStore sharedStore] allGoals] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASGoal *g = [[[ASGoalStore sharedStore] allGoals] objectAtIndex:[indexPath row]];
    ASGoalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ASGoalCell"];
    [[cell goalTitleLabel] setText:[g title]];
    [[cell accumulatedHourLabel] setText:[NSString stringWithFormat:@"%.2fh", [g accumulatedHours]]];
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"ASGoalCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"ASGoalCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

@end
