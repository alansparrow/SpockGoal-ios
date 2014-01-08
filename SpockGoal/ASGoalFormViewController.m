//
//  ASGoalFormViewController.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASGoalFormViewController.h"
#import "ASGoal.h"
#import "ASTimeProcess.h"

@interface ASGoalFormViewController ()

@end

@implementation ASGoalFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initForGoal:(ASGoal *)goal
{
    self = [super initWithNibName:@"ASGoalFormViewController" bundle:nil];
    
    if (self) {
        savedGoal = goal;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if (savedGoal) {
        ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
        
        NSArray *colors = [NSArray arrayWithObjects:[UIColor grayColor],
                           [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0], nil];
        [monButton setTitleColor:[colors objectAtIndex:[savedGoal monday]] forState:UIControlStateNormal];
        [tueButton setTitleColor:[colors objectAtIndex:[savedGoal tuesday]] forState:UIControlStateNormal];
        [wedButton setTitleColor:[colors objectAtIndex:[savedGoal wednesday]] forState:UIControlStateNormal];
        [thuButton setTitleColor:[colors objectAtIndex:[savedGoal thursday]] forState:UIControlStateNormal];
        [friButton setTitleColor:[colors objectAtIndex:[savedGoal friday]] forState:UIControlStateNormal];
        [satButton setTitleColor:[colors objectAtIndex:[savedGoal saturday]] forState:UIControlStateNormal];
        [sunButton setTitleColor:[colors objectAtIndex:[savedGoal sunday]] forState:UIControlStateNormal];
        
        [remindMeSwitch setOn:[savedGoal remindMe]];
        [goalTitleTextField setText:[savedGoal title]];
        [startAtButton setTitle:[timeProcess timeIntervalToString:[savedGoal everydayStartAt]]
                       forState:UIControlStateNormal];
        [finishAtButton setTitle:[timeProcess timeIntervalToString:[savedGoal everydayFinishAt]]
                        forState:UIControlStateNormal];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    // Clear first responder
    [[self view] endEditing:YES];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    NSDate* tp1 = [timeProcess stringToDate:[[startAtButton titleLabel] text]];
    NSDate* tp2 = [timeProcess stringToDate:[[finishAtButton titleLabel] text]];
    
    // "Save" changes to goal
    [savedGoal setTitle:[goalTitleTextField text]];
    [savedGoal setRemindMe:[remindMeSwitch isOn]];
    [savedGoal setEverydayStartAt:[tp1 timeIntervalSinceReferenceDate]];
    [savedGoal setEverydayFinishAt:[tp2 timeIntervalSinceReferenceDate]];
    
    if ([monButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [savedGoal setMonday:NO];
    } else {
        [savedGoal setMonday:YES];
    }
    if ([tueButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [savedGoal setTuesday:NO];
    } else {
        [savedGoal setTuesday:YES];
    }
    if ([wedButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [savedGoal setWednesday:NO];
    } else {
        [savedGoal setWednesday:YES];
    }
    if ([thuButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [savedGoal setThursday:NO];
    } else {
        [savedGoal setThursday:YES];
    }
    if ([friButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [savedGoal setFriday:NO];
    } else {
        [savedGoal setFriday:YES];
    }
    if ([satButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [savedGoal setSaturday:NO];
    } else {
        [savedGoal setSaturday:YES];
    }
    if ([sunButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [savedGoal setSunday:NO];
    } else {
        [savedGoal setSunday:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)monClick:(id)sender {
    if ([monButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [monButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                        forState:UIControlStateNormal];
    } else {
        [monButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)tueClick:(id)sender {
    if ([tueButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [tueButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                        forState:UIControlStateNormal];
    } else {
        [tueButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)wedClick:(id)sender {
    if ([wedButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [wedButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                        forState:UIControlStateNormal];
    } else {
        [wedButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)thuClick:(id)sender {
    if ([thuButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [thuButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                        forState:UIControlStateNormal];
    } else {
        [thuButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)friClick:(id)sender {
    if ([friButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [friButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                        forState:UIControlStateNormal];
    } else {
        [friButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)satClick:(id)sender {
    if ([satButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [satButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                        forState:UIControlStateNormal];
    } else {
        [satButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)startAtClick:(id)sender {
    
}

- (IBAction)finishAtClick:(id)sender {
    
}

- (IBAction)sunClick:(id)sender {
    if ([sunButton titleColorForState:UIControlStateNormal] == [UIColor grayColor]) {
        [sunButton setTitleColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]
                        forState:UIControlStateNormal];
    } else {
        [sunButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

@end
