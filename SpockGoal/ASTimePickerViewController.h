//
//  ASTimePickerViewController.h
//  SpockGoal
//
//  Created by Alan Sparrow on 1/8/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASGoal;

@interface ASTimePickerViewController : UIViewController

{
    __weak IBOutlet UIDatePicker *startAtDatePicker;
    __weak IBOutlet UIDatePicker *finishAtDatePicker;

    ASGoal *savedGoal;
}

- (id)initFor:(ASGoal *)goal;

@end
