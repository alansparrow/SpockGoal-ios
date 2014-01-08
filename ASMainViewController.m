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
#import "ASGoalFormViewController.h"

#define WSLog(...) NSLog(__VA_ARGS__)

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

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectingRow = [indexPath row];
    
    ASGoal *g = [[[ASGoalStore sharedStore] allGoals] objectAtIndex:[indexPath row]];
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:[g title]
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Start",
                                  @"Detail",
                                  @"Edit", nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleDefault];
    [actionSheet showInView:[self view]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    WSLog([NSString stringWithFormat:@"Selecting: %d row", selectingRow]);
    /*
    switch (buttonIndex) {
        case 0:
            WSLog(@"Clicked Start");
            break;
        case 1:
            WSLog(@"Clicked Detail");
            break;
        case 2:
            WSLog(@"Clicked Edit");
            ASGoalFormController *gfc = [[ASGoalFormController alloc] init];
            [[self navigationController] pushViewController:gfc animated:YES];
            break;
        case 3:
            WSLog(@"Clicked Cancel");
            break;
        default:
            break;
    }*/
    
    if (buttonIndex == 2) {
        WSLog(@"Clicked Edit");
        //ASGoalFormViewController *gfc = [[ASGoalFormViewController alloc] init];
        ASGoalFormViewController *gfc = [[ASGoalFormViewController alloc]
                                         initForGoal:[[[ASGoalStore sharedStore] allGoals]
                                                      objectAtIndex:selectingRow]];
        //ASGoalFormViewController *gfc1 = [[ASGoalFormViewController alloc] initForGoal:nil];
        [[self navigationController] pushViewController:gfc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"ASGoalCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"ASGoalCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self tableView] reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

@end
