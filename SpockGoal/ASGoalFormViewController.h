//
//  ASGoalFormViewController.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASGoal;

@interface ASGoalFormViewController : UIViewController
{
    __weak IBOutlet UITextField *goalTitleTextField;
    __weak IBOutlet UIButton *monButton;
    __weak IBOutlet UIButton *tueButton;
    __weak IBOutlet UIButton *wedButton;
    __weak IBOutlet UIButton *thuButton;
    __weak IBOutlet UIButton *friButton;
    __weak IBOutlet UIButton *satButton;
    __weak IBOutlet UIButton *startAtButton;
    __weak IBOutlet UIButton *finishAtButton;
    __weak IBOutlet UISwitch *remindMeSwitch;
    __weak IBOutlet UIButton *sunButton;
    
    ASGoal *savedGoal;
}
- (IBAction)monClick:(id)sender;
- (IBAction)tueClick:(id)sender;
- (IBAction)wedClick:(id)sender;
- (IBAction)thuClick:(id)sender;
- (IBAction)friClick:(id)sender;
- (IBAction)satClick:(id)sender;
- (IBAction)startAtClick:(id)sender;
- (IBAction)finishAtClick:(id)sender;
- (IBAction)sunClick:(id)sender;

- (id)initForGoal:(ASGoal *)goal;


@end
