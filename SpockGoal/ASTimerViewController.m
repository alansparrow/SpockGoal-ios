//
//  ASTimerViewController.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/9/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASTimerViewController.h"
#import "ASGoal.h"
#import "ASGoalStore.h"
#import "ASRecord.h"
#import "ASTimeProcess.h"


@interface ASTimerViewController ()

@end

@implementation ASTimerViewController

@synthesize dismissBlock;

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
    self = [super initWithNibName:@"ASTimerViewController" bundle:nil];
    
    if (self) {
        savedGoal = goal;
    }
    
    return self;
}

- (void)updateTimer
{
    // Current time
    current = [NSDate date];
    NSTimeInterval startTimeValue = [start timeIntervalSinceReferenceDate];
    NSTimeInterval currentTimeValue = [current timeIntervalSinceReferenceDate];
    NSDate *timer = [NSDate dateWithTimeIntervalSince1970:currentTimeValue-startTimeValue];
    
    // Date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timer];
    [timerLabel setText:timeString];
    
    // Save it so anytime the disruption comes
    // it will be saved
    [self saveToRecord];
}

- (void)saveToRecord
{
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    
    current = [NSDate date];
    NSTimeInterval startTimeValue = [start timeIntervalSinceReferenceDate];
    NSTimeInterval currentTimeValue = [current timeIntervalSinceReferenceDate];
    [savedRecord setRealStartAt:startTimeValue];
    [savedRecord setRealFinishAt:currentTimeValue];
    [savedRecord setDuration:(currentTimeValue - startTimeValue)/3600.0]; // change to hour
    [savedRecord setAccuracy:[timeProcess accuracyOf:savedRecord accordingTo:savedGoal]];
    [savedRecord setCreatedYear:[timeProcess yearFromDate:current]];
    [savedRecord setCreatedMonth:[timeProcess monthFromDate:current]];
    [savedRecord setCreatedDay:[timeProcess dayFromDate:current]];
    [savedRecord setQuality:@"Medium"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Set Goal's title
    [goalTitleLabel setText:[savedGoal title]];
    
    // Set start time
    start = [NSDate date];
    savedRecord = [[ASGoalStore sharedStore] createRecordForGoal:savedGoal];

    
    
    // Create the stop watch timer that fires every 10ms
    stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                      target:self
                                                    selector:@selector(updateTimer)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finishButtonClick:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"My Performance"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"High",
                                  @"Medium",
                                  @"Low", nil];
    [actionSheet setActionSheetStyle:UIActionSheetStyleDefault];
    [actionSheet showInView:[self view]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
        [savedRecord setQuality:@"High"];
        [[self presentingViewController]
         dismissViewControllerAnimated:YES completion:dismissBlock];
    } else if (buttonIndex == 1) {
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
        [savedRecord setQuality:@"Medium"];
        [[self presentingViewController]
         dismissViewControllerAnimated:YES completion:dismissBlock];
    } else if (buttonIndex == 2) {
        [stopWatchTimer invalidate];
        stopWatchTimer = nil;
        [savedRecord setQuality:@"Low"];
        [[self presentingViewController]
         dismissViewControllerAnimated:YES completion:dismissBlock];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


@end
