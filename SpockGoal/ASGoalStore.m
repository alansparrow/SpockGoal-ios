//
//  ASGoalStore.m
//  SpockGoal
//
//  Created by Alan Sparrow on 1/7/14.
//  Copyright (c) 2014 Alan Sparrow. All rights reserved.
//

#import "ASGoalStore.h"
#import "ASGoal.h"
#import "ASRecord.h"
#import "ASRandom.h"
#import "ASTimeProcess.h"

@implementation ASGoalStore

+ (ASGoalStore *)sharedStore
{
    static ASGoalStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Read in SpockGoal.xcdatamodeld
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        NSString *path = [self goalArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        [context setUndoManager:nil];
        
        [self loadAllGoals];
    }
    
    return self;
}

- (void)loadAllGoals
{
    if (!allGoals) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"ASGoal"];
        [request setEntity:e];
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allGoals = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSString *)goalArchivePath
{
    NSArray *documentDirectories =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (NSArray *)allGoals
{
    return allGoals;
}

- (ASGoal *)createGoal
{
    double order;
    if ([allGoals count] == 0) {
        order = 1.0;
    } else {
        // Because when fetch from DB allGoals already been in order
        order = [[allGoals lastObject] orderingValue] + 1.0;
    }
    ASGoal *g = [NSEntityDescription insertNewObjectForEntityForName:@"ASGoal"
                                              inManagedObjectContext:context];
    [g setOrderingValue:order];
    [g setTitle:@""]; // default for goal's title
    [g setCreatedDate:[NSDate timeIntervalSinceReferenceDate]];
    
    [allGoals addObject:g];
    
    return g;
}

- (ASGoal *)createRandomGoal
{
    
    ASRandom *random = [[ASRandom alloc] init];
    //ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    ASGoal *g = [self createGoal];
    
    [g setTitle:[random randomGoalTitle]];
    [g setMonday:[random randomBoolean]];
    [g setTuesday:[random randomBoolean]];
    [g setWednesday:[random randomBoolean]];
    [g setThursday:[random randomBoolean]];
    [g setFriday:[random randomBoolean]];
    [g setSaturday:[random randomBoolean]];
    [g setSunday:[random randomBoolean]];
    [g setRemindMe:[random randomBoolean]];
    [g setEverydayStartAt:[[random randomTimePoint1] timeIntervalSinceReferenceDate]];
    [g setEverydayFinishAt:[[random randomTimePoint2] timeIntervalSinceReferenceDate]];
    
    return g;
}

- (ASRecord *)createRandomRecordForGoal:(ASGoal *)goal
{
    
    ASRandom *random = [[ASRandom alloc] init];
    ASRecord *r = [NSEntityDescription insertNewObjectForEntityForName:@"ASRecord"
                                              inManagedObjectContext:context];
    [r setDuration:[random randomDuration]];
    [r setQuality:[random randomQuality]];
    [r setNote:[random randomNote]];
    
    [goal addRecordsObject:r];
    
    return r;
}

- (void)removeGoal:(ASGoal *)g
{
    [context deleteObject:g];
    [allGoals removeObjectIdenticalTo:g];
    [self saveChanges];
}

- (BOOL)saveChanges
{
    // Remove all empty and time failed goal
    // In case of sudden suspend
    for (ASGoal *g in [self allGoals]) {
        if ([[g title] isEqual:@""] || ![self checkTimeOf:g]) {
            if ([[g records] count] == 0) {
                [context deleteObject:g];
                [allGoals removeObjectIdenticalTo:g];
            }
        }
    }
    
    NSError *error = nil;
    BOOL successful = [context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    return successful;
}

- (BOOL)checkTimeOf:(ASGoal *)g
{
    BOOL resultBoolean = NO;
    
    ASTimeProcess *timeProcess = [[ASTimeProcess alloc] init];
    NSInteger tp1 = [timeProcess
                     timePointToInt:
                     [timeProcess dateFromTimeInterval:[g everydayStartAt]]
                     ];
    NSInteger tp2 = [timeProcess
                     timePointToInt:
                     [timeProcess dateFromTimeInterval:[g everydayFinishAt]]
                     ];
    if (tp1 <= tp2) {
        resultBoolean = YES;
    }
    
    return resultBoolean;
}

- (void)moveGoalAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    
    ASGoal *g = [allGoals objectAtIndex:from];
    [allGoals removeObjectAtIndex:from];
    [allGoals insertObject:g atIndex:to];
    
    double lowerBound = 0.0;
    if (to > 0) {
        lowerBound = [[allGoals objectAtIndex:to-1] orderingValue];
    } else {
        lowerBound = [[allGoals objectAtIndex:1] orderingValue] - 2.0;
    }
    
    double upperBound = 0.0;
    if (to < [allGoals count] - 1) {
        upperBound = [[allGoals objectAtIndex:to+1] orderingValue];
    } else {
        upperBound = [[allGoals objectAtIndex:to-1] orderingValue] + 2.0;
    }
    
    double newOrderValue = (lowerBound + upperBound) / 2.0;
    
    [g setOrderingValue:newOrderValue];
}



@end
