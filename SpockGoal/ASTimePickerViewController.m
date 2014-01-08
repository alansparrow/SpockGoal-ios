//
//  ASTimePickerViewController.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASTimePickerViewController.h"
#import "ASGoal.h"
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

- (id)initFor:(ASGoal *)goal
{
    self = [super initWithNibName:@"ASTimePickerViewController" bundle:nil];
    
    if (self) {
        savedGoal = goal;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [startAtDatePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[savedGoal everydayStartAt]]];
    [finishAtDatePicker setDate:[NSDate dateWithTimeIntervalSinceReferenceDate:[savedGoal everydayFinishAt]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSDate *date1 = [startAtDatePicker date];
    NSDate *date2 = [finishAtDatePicker date];
    
    [savedGoal setEverydayStartAt:[date1 timeIntervalSinceReferenceDate]];
    [savedGoal setEverydayFinishAt:[date2 timeIntervalSinceReferenceDate]];
    
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    NSLog(@"%@", [timeProcess timeIntervalToString:[savedGoal everydayStartAt]]);
    NSLog(@"%@", [timeProcess timeIntervalToString:[savedGoal everydayFinishAt]]);
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
