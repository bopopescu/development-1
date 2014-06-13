//
//  DHAPBeaconCatManager.m
//  DHAPBeaconCatLibrary
//
//  Created by Kevin Kim on 5/6/14.
//  Copyright (c) 2014 DHAP Digital. All rights reserved.
//

#import "DHAPBeaconCatManager.h"
#import "DHAPBeaconCat.h"


@interface DHAPBeaconCatManager ()
@property (strong, nonatomic, readwrite) NSUUID *uuid;
@property (strong, nonatomic, readwrite) NSArray *cats;

@property (strong, nonatomic) NSDictionary *resources;
@end


@implementation DHAPBeaconCatManager

+ (instancetype)sharedInstance
{
    static id __instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[self alloc] initForResource:@"DHAPBeaconCat"];
    });
    return __instance;
}

- (instancetype)initForResource:(NSString *)resource
{
    self = [super init];
    if (self) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:resource ofType:@"plist"];
        self.resources = [NSDictionary dictionaryWithContentsOfFile:resourcePath];
    }
    return self;
}

- (NSUUID *)uuid
{
    if (nil == _uuid) {
        _uuid = [[NSUUID alloc] initWithUUIDString:self.resources[@"uuid"]];
    }
    return _uuid;
}

- (NSString *)identifier
{
    return @"org.kittyloft.beacons";
}

- (NSArray *)cats
{
    if (nil == _cats) {
        NSMutableArray *mutCats = [NSMutableArray array];
        for (NSDictionary *catDict in self.resources[@"cats"]) {
            DHAPBeaconCat *cat = [[DHAPBeaconCat alloc] initWithDictionary:catDict];
            [mutCats addObject:cat];
        }
        _cats = [NSArray arrayWithArray:mutCats];
    }
    return _cats;
}

@end
