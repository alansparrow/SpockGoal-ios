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

#define ASLog(...) NSLog(__VA_ARGS__)

@implementation ASMainViewController

- (id)init
{
    // Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Create a new bar button item that will send
        // addNewGoal: to MainViewController
        UINavigationItem *navItem = [self navigationItem];
        [navItem setTitle:@"SpockGoal"];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewGoal:)];
        // Set this bar button item as the right item in the navigationItem
        [[self navigationItem] setRightBarButtonItem:bbi];
        [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
        
    }
    return self;
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

        
        ASGoalStore *gs = [ASGoalStore sharedStore];
        NSArray *goals = [gs allGoals];
        ASGoal *g = [goals objectAtIndex:[indexPath row]];
        [gs removeGoal:g];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[self tableView] reloadData];
    // turn off Editting mode so the right label can be shown
    // if not the new created goal hour label will be empty
    [self setEditing:NO animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

@end
