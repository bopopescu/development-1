//
//  DHAPBeaconCat+Client.h
//  DHAPBeaconCatClient
//
//  Created by Kevin Y. Kim on 10/23/13.
//  Copyright (c) 2013 AppOrchard, LLC. All rights reserved.
//

#import "DHAPBeaconCatLibrary/DHAPBeaconCatLibrary.h"
#import <CoreLocation/CoreLocation.h>

@interface DHAPBeaconCat (Client)

+ (CLBeaconRegion *)catsRegion;
- (CLBeaconRegion *)beaconRegion;

- (UIImage *)image;

@end
