//
//  TableViewStory.h
//  iBeaconTableViewStory
//
//  Created by Brian Sterner on 6/10/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iBeaconPersistanceManager : NSObject

- (void) saveBeacons:(NSArray*)beaconItems;

@end
