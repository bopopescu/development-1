//
//  DiceDataController.m
//  DiceRoll
//
//  Created by Christopher Ching on 2013-09-19.
//  Copyright (c) 2013 CodeWithChris. All rights reserved.
//

#import "DiceDataController.h"

@implementation DiceDataController

- (int)getDieNumber {
    int r = (arc4random() % 6) + 1;
    
    return r;
}


@end
