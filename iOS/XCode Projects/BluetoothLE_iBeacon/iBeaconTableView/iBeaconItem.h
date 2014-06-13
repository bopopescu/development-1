//
//  iBeaconItem.h
//
//  Created by Brian Sterner on 6/10/14.
//

#import <Foundation/Foundation.h>

@import CoreLocation;

@interface iBeaconItem : NSObject <NSCoding>

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSUUID *uuid;
@property (assign, nonatomic, readonly) CLBeaconMajorValue majorValue;
@property (assign, nonatomic, readonly) CLBeaconMinorValue minorValue;
@property (strong, nonatomic) CLBeacon *lastSeenBeacon;

- (instancetype)initWithName:(NSString *)name
                        uuid:(NSUUID *)uuid
                       major:(CLBeaconMajorValue)major
                       minor:(CLBeaconMinorValue)minor;

- (BOOL)isEqualToCLBeacon:(CLBeacon *)beacon;
//- (BOOL)isEqual:(id)beacon;
- (BOOL)isEqual:(iBeaconItem *) beacon;

@end
