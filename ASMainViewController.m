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
#import "ASTimerViewController.h"
#import "ASRecordListController.h"
#import "ASTimeProcess.h"
#import "NSDate+TimeAgo.h"

#define ASLog(...) NSLog(__VA_ARGS__)

@implementation ASMainViewController

- (id)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [self setupTableViewUI];
    }
    return self;
}

- (void)setupTableViewUI
{
    // Set Custom UI for navBar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBar.png"]
                                       forBarMetrics:UIBarMetricsDefault];

    
    // Create a new bar button item that will send
    // addNewGoal: to MainViewController
    UINavigationItem *navItem = [self navigationItem];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    [label setFrame:CGRectMake(0, 0, 100, 35)];
    label.font = [UIFont boldSystemFontOfSize:22.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Spock Goal";
    
    [navItem setTitleView:label];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self
                            action:@selector(addNewGoal:)];
    // Set color for bar button item
    [bbi setTintColor:[UIColor whiteColor]];
    [[self editButtonItem] setTintColor:[UIColor whiteColor]];
    
    // Set this bar button item as the right item in the navigationItem
    [[self navigationItem] setRightBarButtonItem:bbi];
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    [[self tableView] setSeparatorInset:UIEdgeInsetsZero];
    //[[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
}

- (IBAction)addNewGoal:(id)sender
{
    ASGoal *newGoal = [[ASGoalStore sharedStore] createGoal];
    
    // New goal so initForGoal:nil
    ASGoalFormViewController *gfc = [[ASGoalFormViewController alloc] initForGoal:newGoal
                                     newGoal:YES];
    
    [gfc setDismissBlock:^void{
        [[self tableView] reloadData];
    }];
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:gfc];
    [navController setModalPresentationStyle:UIModalPresentationFullScreen];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navController
                       animated:YES
                     completion:nil];
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
    float accumulatedHours = [g accumulatedHours];
    [[cell accumulatedHourLabel] setText:[NSString stringWithFormat:@"%.2fh", accumulatedHours]];
    
    [self setupCellUI:cell forGoal:g];
    
    return cell;
}

- (void)setupCellUI:(ASGoalCell *)cell forGoal:(ASGoal *)g
{
    
    // Set background color to light blue
    [[cell accumulatedHourLabel] setBackgroundColor:[UIColor colorWithRed:91.0/255.0
                                                             green:192.0/255.0
                                                              blue:222.0/255.0 alpha:1.0]];
    
    [[cell accumulatedHourLabel] setTextColor:[UIColor whiteColor]];
    [[[cell accumulatedHourLabel] layer] setCornerRadius:10.0];
    
    
    [[[cell iconImage] layer] setCornerRadius:20];
    [[[cell iconImage] layer] setBorderWidth:1.0];
    [[[cell iconImage] layer] setBorderColor:[[UIColor colorWithRed:164.0/255.0
                                                       green:16.0/255.0
                                                        blue:52.0/255.0
                                                       alpha:1.0] CGColor]];
    [[[cell iconImage] layer] setBackgroundColor:[[UIColor colorWithRed:164.0/255.0
                                                           green:16.0/255.0
                                                            blue:52.0/255.0
                                                           alpha:1.0] CGColor]];
    [[[cell iconImage] layer] setMasksToBounds:YES];
    [[cell iconImage] sizeToFit];
    
    
    //-----------
    ASRecord *lastRecord = [[ASGoalStore sharedStore] newestRecordOfGoal:g];
    
    if (lastRecord) {
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:
                        [lastRecord realStartAt]];
        
        
        NSString *lastTime = [date timeAgo];
        [[cell lastTimeLabel] setText:lastTime];
    } else {
        [[cell lastTimeLabel] setText:@"No record"];
    }
    
    
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    [[cell scheduleLabel] setText:[NSString stringWithFormat:@"%@ - %@",
                                   [timeProcess timeIntervalToString:[g everydayStartAt]],
                                   [timeProcess timeIntervalToString:[g everydayFinishAt]]]];
    if ([g monday]) {
        [[cell mondayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                         green:0.0
                                                          blue:0.0
                                                         alpha:0.7]];
    } else {
        [[cell mondayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                         green:0.0
                                                          blue:0.0
                                                         alpha:0.2]];
    }
    
    if ([g tuesday]) {
        [[cell tuesdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                          green:0.0
                                                           blue:0.0
                                                          alpha:0.7]];
    } else {
        [[cell tuesdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                          green:0.0
                                                           blue:0.0
                                                          alpha:0.2]];
    }
    if ([g wednesday]) {
        [[cell wednesdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                            green:0.0
                                                             blue:0.0
                                                            alpha:0.7]];
    } else {
        [[cell wednesdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                            green:0.0
                                                             blue:0.0
                                                            alpha:0.2]];
    }
    if ([g thursday]) {
        [[cell thursdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                           green:0.0
                                                            blue:0.0
                                                           alpha:0.7]];
    } else {
        [[cell thursdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                           green:0.0
                                                            blue:0.0
                                                           alpha:0.2]];
    }
    if ([g friday]) {
        [[cell fridayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                         green:0.0
                                                          blue:0.0
                                                         alpha:0.7]];
    } else {
        [[cell fridayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                         green:0.0
                                                          blue:0.0
                                                         alpha:0.2]];
    }
    if ([g saturday]) {
        [[cell saturdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                           green:0.0
                                                            blue:0.0
                                                           alpha:0.7]];
    } else {
        [[cell saturdayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                           green:0.0
                                                            blue:0.0
                                                           alpha:0.2]];
    }
    if ([g sunday]) {
        [[cell sundayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                         green:0.0
                                                          blue:0.0
                                                         alpha:0.7]];
    } else {
        [[cell sundayLabel] setTextColor:[UIColor colorWithRed:0.0
                                                         green:0.0
                                                          blue:0.0
                                                         alpha:0.2]];
    }
    
    if ([g remindMe]) {
        [[cell alarmIcon] setHidden:NO];
    } else {
        [[cell alarmIcon] setHidden:YES];
    }
    
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
    ASLog([NSString stringWithFormat:@"Selecting: %d row", selectingRow]);
    
    if (buttonIndex == 0) {
        ASLog(@"Clicked Start");
        ASTimerViewController *tvc = [[ASTimerViewController alloc]
                                      initFor:[[[ASGoalStore sharedStore] allGoals]
                                               objectAtIndex:selectingRow]];
        [tvc setDismissBlock:^void{
            [[self tableView] reloadData];
        }];
        
        [self presentViewController:tvc
                           animated:YES
                         completion:nil];
        
    } else if (buttonIndex == 1) {
        ASLog(@"Clicked Detail");
        ASRecordListController *rvc = [[ASRecordListController alloc]
                                       initFor:[[[ASGoalStore sharedStore] allGoals]
                                                objectAtIndex:selectingRow]];
        [rvc setDismissBlock:^void{
            [[self tableView] reloadData];
        }];
        
        UINavigationController *navController = [[UINavigationController alloc]
                                                 initWithRootViewController:rvc];
        [navController setModalPresentationStyle:UIModalPresentationFullScreen];
        [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        
        [self presentViewController:navController
                           animated:YES
                         completion:nil];
        
        
    } else if (buttonIndex == 2) {
        
        ASLog(@"Clicked Edit");
        //ASGoalFormViewController *gfc = [[ASGoalFormViewController alloc] init];
        ASGoalFormViewController *gfc = [[ASGoalFormViewController alloc]
                                         initForGoal:[[[ASGoalStore sharedStore] allGoals]
                                                      objectAtIndex:selectingRow]
                                         newGoal:NO];
        [gfc setDismissBlock:^void{
            [[self tableView] reloadData];
        }];
        
        UINavigationController *navController = [[UINavigationController alloc]
                                                 initWithRootViewController:gfc];
        [navController setModalPresentationStyle:UIModalPresentationFullScreen];
        [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        
        [self presentViewController:navController
                           animated:YES
                         completion:nil];

    }
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];

        
        ASGoalStore *gs = [ASGoalStore sharedStore];
        NSArray *goals = [gs allGoals];
        ASGoal *g = [goals objectAtIndex:[indexPath row]];
        [timeProcess removeAlarmForGoal:g]; // remove alarms
        [gs removeGoal:g]; // remove from DB
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        // check if it deleted the last goal
        [self checkForEmptyGoal];
        
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ASGoalStore sharedStore] moveGoalAtIndex:[sourceIndexPath row]
                                       toIndex:[destinationIndexPath row]];
}



- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing == YES) {
        for (ASGoalCell *gc in [[self tableView] visibleCells]) {
            [[gc accumulatedHourLabel] setHidden:YES];
        }
    } else {
        for (ASGoalCell *gc in [[self tableView] visibleCells]) {
            [[gc accumulatedHourLabel] setHidden:NO];
        }
    }
    
}


    
- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"ASGoalCell" bundle:nil];
    [[self tableView] registerNib:nib forCellReuseIdentifier:@"ASGoalCell"];
    
    // Add refresh when pull
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refresh addTarget:self action:@selector(reloadTableView:)
     
      forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
    
}

- (IBAction)reloadTableView:(id)sender
{
    [[self tableView] reloadData];
    [[self refreshControl] endRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self tableView] reloadData];
    // turn off Editting mode so the right label can be shown
    // if not the new created goal hour label will be empty
    [self setEditing:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self checkForEmptyGoal];
}

- (void)checkForEmptyGoal
{
    if ([[[ASGoalStore sharedStore] allGoals] count] == 0) {
//        UIView *emptyView = [[UIView alloc] initWithFrame:self.tableView.frame];
        UIImageView *emptyView = [[UIImageView alloc] initWithFrame:[[self tableView] frame]];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if (UIDeviceOrientationIsPortrait([self interfaceOrientation])) {
                [emptyView setImage:[UIImage imageNamed:@"emptyGoalView-Portrait.png"]];
            } else {
                [emptyView setImage:[UIImage imageNamed:@"emptyGoalView-Landscape.png"]];
            }
        } else {
            [emptyView setImage:[UIImage imageNamed:@"emptyGoalView-Portrait@2x~iphone.png"]];
        }
        
        /* Customize your view here or load it from a NIB */
        self.tableView.tableHeaderView = emptyView;
        self.tableView.userInteractionEnabled = NO;
    } else {
        self.tableView.tableHeaderView = nil;
        self.tableView.userInteractionEnabled = YES;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self checkForEmptyGoal];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

@end
