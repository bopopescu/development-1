//
//  iBeaconItem.m
//
//  Created by Brian Sterner on 6/10/14.
//

#import "iBeaconItem.h"

static NSString * const kDHAPItemNameKey = @"name";
static NSString * const kDHAPItemUUIDKey = @"uuid";
static NSString * const kDHAPItemMajorValueKey = @"major";
static NSString * const kDHAPItemMinorValueKey = @"minor";

@implementation iBeaconItem

- (instancetype)initWithName:(NSString *)name
                        uuid:(NSUUID *)uuid
                       major:(CLBeaconMajorValue)major
                       minor:(CLBeaconMinorValue)minor
{
    self = [super init];
    if (!self) {
        return nil;
    }

    _name = name;
    _uuid = uuid;
    _majorValue = major;
    _minorValue = minor;

    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _name = [aDecoder decodeObjectForKey:kDHAPItemNameKey];
    _uuid = [aDecoder decodeObjectForKey:kDHAPItemUUIDKey];
    _majorValue = [[aDecoder decodeObjectForKey:kDHAPItemMajorValueKey] unsignedIntegerValue];
    _minorValue = [[aDecoder decodeObjectForKey:kDHAPItemMinorValueKey] unsignedIntegerValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kDHAPItemNameKey];
    [aCoder encodeObject:self.uuid forKey:kDHAPItemUUIDKey];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.majorValue] forKey:kDHAPItemMajorValueKey];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.minorValue] forKey:kDHAPItemMinorValueKey];
}

- (BOOL)isEqualToCLBeacon:(CLBeacon *)beacon {
    if ([[beacon.proximityUUID UUIDString] isEqualToString:[self.uuid UUIDString]] &&
        [beacon.major isEqual: @(self.majorValue)] &&
        [beacon.minor isEqual: @(self.minorValue)])
    {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isEqual:(iBeaconItem *) beacon
{
    NSLog(@"Testing for equality with instance detail info: %@, %hu, %hu", beacon.uuid.UUIDString, beacon.majorValue, beacon.minorValue);
    
    if (beacon == self || ([[beacon.uuid UUIDString] isEqualToString:[self.uuid UUIDString]] &&
        beacon.majorValue == self.majorValue &&
        beacon.minorValue == self.minorValue))
    {
        return YES;
    } else {
        return NO;
    }
}

@end
