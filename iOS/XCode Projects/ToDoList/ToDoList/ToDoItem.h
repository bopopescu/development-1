//
//  ToDoItem.h
//  ToDoList
//
//  Created by Brian Sterner on 5/7/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
