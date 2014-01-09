//
//  ASRecordListController.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/9/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASRecordListController.h"
#import "ASGoal.h"
#import "ASRecordCell.h"
#import "ASRecord.h"
#import "ASTimeProcess.h"

@interface ASRecordListController ()

@end

@implementation ASRecordListController

@synthesize dismissBlock;

- (id)initFor:(ASGoal *)goal
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        savedGoal = goal;
        
        [[self navigationItem] setTitle:[savedGoal title]];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Back"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(cancel:)];
        [cancelItem setTitle:@"Back"];
        [[self navigationItem] setLeftBarButtonItem:cancelItem];
    }
    
    return self;
}

- (IBAction)cancel:(id)sender
{
    // Move back
    [[self presentingViewController]
     dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self initFor:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"ASRecordCell" bundle:nil];
    [[self tableView] registerNib:nib
           forCellReuseIdentifier:@"ASRecordCell"];
    
    sortedRecords = [NSMutableArray arrayWithArray:[[savedGoal records] allObjects]];
    
    sortedRecords = [NSMutableArray arrayWithArray:[sortedRecords sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSTimeInterval t1 = [(ASRecord*)obj1 realStartAt];
        NSTimeInterval t2 = [(ASRecord*)obj2 realStartAt];
        
        if (t1 > t2) {
            return NSOrderedAscending;
        } else if (t1 < t2) {
            return NSOrderedDescending;
        } else
            return NSOrderedSame;
    }]
                     ];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    
    ASRecord *r = [sortedRecords objectAtIndex:[indexPath row]];
    
    ASRecordCell *cell = [tableView
                          dequeueReusableCellWithIdentifier:@"ASRecordCell"];
    [[cell dateLabel]
     setText:[timeProcess
              dateToString:[NSDate
                            dateWithTimeIntervalSinceReferenceDate:[r realStartAt]]]];
    [[cell qualityLabel] setText:[r quality]];
    
    NSString *timeString = [NSString stringWithFormat:@"%@ - %@",
                            [timeProcess
                             timeStringFromTimeInterval:[r realStartAt]],
                            [timeProcess
                             timeStringFromTimeInterval:[r realFinishAt]]];
    
    [[cell timeLabel] setText:timeString];
    
    NSString *durationString = [NSString stringWithFormat:@"%.2fh",
                                [r duration]];
    [[cell durationLabel] setText:durationString];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[savedGoal records] count];
}



@end
