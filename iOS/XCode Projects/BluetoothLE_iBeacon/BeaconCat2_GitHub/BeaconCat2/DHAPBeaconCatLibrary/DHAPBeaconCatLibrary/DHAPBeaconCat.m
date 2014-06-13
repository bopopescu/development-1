//
//  DHAPBeaconCat.m
//  DHAPBeaconCatLibrary
//
//  Created by Kevin Kim on 5/6/14.
//  Copyright (c) 2014 DHAP Digital. All rights reserved.
//

#import "DHAPBeaconCat.h"

@implementation DHAPBeaconCat

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.major = [dictionary objectForKey:@"major"];
        self.minor = [dictionary objectForKey:@"minor"];
        self.name = [dictionary objectForKey:@"name"];
        self.bio = [dictionary objectForKey:@"bio"];
    }
    return self;
}

@end
