//
//  ASTimePickerViewController.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASTimePickerViewController.h"
#import "ASGoalCopy.h"
#import "ASTimeProcess.h"

@interface ASTimePickerViewController ()

@end

@implementation ASTimePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initFor:(ASGoalCopy *)g
{
    self = [super initWithNibName:@"ASTimePickerViewController" bundle:nil];
    
    if (self) {
        copyGoal = g;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([copyGoal everydayStartAt]) {
        [startAtDatePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[copyGoal everydayStartAt]]];
        [finishAtDatePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[copyGoal everydayFinishAt]]];

    } else {
        [startAtDatePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[NSDate timeIntervalSinceReferenceDate]]];
        [finishAtDatePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[NSDate timeIntervalSinceReferenceDate]]];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date1 = [startAtDatePicker date];
    NSDate *date2 = [finishAtDatePicker date];
    
    [copyGoal setEverydayStartAt:[date1 timeIntervalSinceReferenceDate]];
    [copyGoal setEverydayFinishAt:[date2 timeIntervalSinceReferenceDate]];
    
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    NSLog(@"%@", [timeProcess timeIntervalToString:[copyGoal everydayStartAt]]);
    NSLog(@"%@", [timeProcess timeIntervalToString:[copyGoal everydayFinishAt]]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
