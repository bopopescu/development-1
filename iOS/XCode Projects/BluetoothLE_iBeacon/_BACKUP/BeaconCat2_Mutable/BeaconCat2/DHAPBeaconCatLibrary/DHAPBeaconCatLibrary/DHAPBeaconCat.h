//
//  DHAPBeaconCat.h
//  DHAPBeaconCatLibrary
//
//  Created by Kevin Kim on 5/6/14.
//  Copyright (c) 2014 DHAP Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHAPBeaconCat : NSObject

@property (nonatomic, strong) NSNumber *major;
@property (nonatomic, strong) NSNumber *minor;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *bio;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
