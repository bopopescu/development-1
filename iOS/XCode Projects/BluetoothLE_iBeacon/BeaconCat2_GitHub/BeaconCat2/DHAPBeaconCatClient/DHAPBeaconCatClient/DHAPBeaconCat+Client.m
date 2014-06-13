//
//  DHAPBeaconCat+Client.m
//  DHAPBeaconCatClient
//
//  Created by Kevin Y. Kim on 10/23/13.
//  Copyright (c) 2013 AppOrchard, LLC. All rights reserved.
//

#import "DHAPBeaconCat+Client.h"

@implementation DHAPBeaconCat (Client)

+ (CLBeaconRegion *)catsRegion
{
    NSUUID *uuid = [[DHAPBeaconCatManager sharedInstance] uuid];
    NSString *identifier = [[DHAPBeaconCatManager sharedInstance] identifier];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:identifier];
    return region;
}

- (CLBeaconRegion *)beaconRegion
{
    NSUUID *uuid = [[DHAPBeaconCatManager sharedInstance] uuid];
    NSString *identifier = [[DHAPBeaconCatManager sharedInstance] identifier];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid major:[self.major shortValue] minor:[self.minor shortValue] identifier:identifier];
    return region;
}

- (UIImage *)image
{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[self.minor stringValue] ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    return image;
}

@end
