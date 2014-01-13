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
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        [label setFrame:CGRectMake(0, 0, 100, 35)];
        label.font = [UIFont boldSystemFontOfSize:22.0];
        label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.text = [goal title];
        [[self navigationItem] setTitleView:label];
        
        [[self navigationItem] setTitle:[savedGoal title]];
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Back"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(cancel:)];
        [cancelItem setTitle:@"Back"];
        [cancelItem setTintColor:[UIColor whiteColor]];
        [[self navigationItem] setLeftBarButtonItem:cancelItem];
        
        [[self tableView] setSeparatorInset:UIEdgeInsetsZero];
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
    
    [self checkForEmptyRecord];
}

- (void)checkForEmptyRecord
{
    if ([[[savedGoal records] allObjects] count] == 0) {
        //        UIView *emptyView = [[UIView alloc] initWithFrame:self.tableView.frame];
        UIImageView *emptyView = [[UIImageView alloc] initWithFrame:[[self tableView] frame]];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if (UIDeviceOrientationIsPortrait([self interfaceOrientation])) {
                [emptyView setImage:[UIImage imageNamed:@"emptyRecordView-Portrait.png"]];
            } else {
                [emptyView setImage:[UIImage imageNamed:@"emptyRecordView-Landscape.png"]];
            }
        } else {
            [emptyView setImage:[UIImage imageNamed:@"emptyRecordView-Portrait@2x~iphone.png"]];
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
    [self checkForEmptyRecord];
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
    [self setupCellUI:cell forRecord:r];
    
    return cell;
}

- (void)setupCellUI:(ASRecordCell *)cell forRecord:(ASRecord *)r
{
    [[cell durationLabel] setTextColor:[UIColor whiteColor]];
    [[cell durationLabel] setBackgroundColor:[UIColor colorWithRed:91.0/255.0
                                                      green:192.0/255.0
                                                       blue:222.0/255.0 alpha:1.0]];
    [[[cell durationLabel] layer] setCornerRadius:10.0];
    
    [[cell qualityLabel] setTextColor:[UIColor whiteColor]];
    [[[cell qualityLabel] layer] setCornerRadius:10.0];
    
    if ([[[cell qualityLabel] text] isEqualToString:@"High"]) {
        [[cell qualityLabel] setBackgroundColor:[UIColor colorWithRed:212.0/255.0
                                                         green:63.0/255.0
                                                          blue:58.0/255.0 alpha:1.0]];
    } else if ([[[cell qualityLabel] text] isEqualToString:@"Medium"]) {
        [[cell qualityLabel] setBackgroundColor:[UIColor colorWithRed:212.0/255.0
                                                         green:63.0/255.0
                                                          blue:58.0/255.0 alpha:0.6]];
    } else {
        [[cell qualityLabel] setBackgroundColor:[UIColor colorWithRed:212.0/255.0
                                                         green:63.0/255.0
                                                          blue:58.0/255.0 alpha:0.2]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[savedGoal records] count];
}



@end
