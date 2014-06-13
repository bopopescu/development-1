//
//  TableViewStory.m
//  iBeaconTableViewStory
//
//  Created by Brian Sterner on 6/10/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import "iBeaconPersistanceManager.h"
#import "iBeaconItem.h"

NSString * const kBeaconStoredItemsKey = @"savedBeacons";

@implementation iBeaconPersistanceManager

- (void) saveBeacons:(NSArray*)beaconItems
{
    NSMutableArray *iBeaconItemsData = [NSMutableArray array];

    for (iBeaconItem *beacon in beaconItems) {
        // Serialize / encode beacon item to be archived
        NSData *itemData = [NSKeyedArchiver archivedDataWithRootObject:beacon];
        [iBeaconItemsData addObject:itemData];
    }

    [[NSUserDefaults standardUserDefaults] setObject:iBeaconItemsData forKey:kBeaconStoredItemsKey];
    
    NSInteger cnt = [iBeaconItemsData count];
    NSLog(@"iBeaconItemsData size is: %ld", (long)cnt);
}

@end
