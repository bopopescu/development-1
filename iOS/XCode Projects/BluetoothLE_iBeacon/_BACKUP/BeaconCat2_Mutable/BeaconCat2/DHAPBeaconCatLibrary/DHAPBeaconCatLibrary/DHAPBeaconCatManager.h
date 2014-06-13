//
//  DHAPBeaconCatManager.h
//  DHAPBeaconCatLibrary
//
//  Created by Kevin Kim on 5/6/14.
//  Copyright (c) 2014 DHAP Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHAPBeaconCatManager : NSObject

@property (strong, nonatomic, readonly) NSUUID *uuid;
@property (strong, nonatomic, readonly) NSString *identifier;
@property (strong, nonatomic, readonly) NSArray *cats;

+ (instancetype)sharedInstance;

- (instancetype)initForResource:(NSString *)resource;

@end
