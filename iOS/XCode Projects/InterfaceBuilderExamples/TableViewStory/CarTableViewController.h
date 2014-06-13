//
//  CarTableViewController.h
//  TableViewStory
//
//  Created by Brian Sterner on 6/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *carImages;
@property (nonatomic, strong) NSArray *carMakes;
@property (nonatomic, strong) NSArray *carModels;

@end
