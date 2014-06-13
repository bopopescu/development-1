//
//  CarDetailViewController.h
//  TableViewStory
//
//  Created by Brian Sterner on 6/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBeaconItem.h"

@interface iBeaconDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *makeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)saveBeacon;

@property (strong, nonatomic) NSArray *carDetailModel;
@property (strong, nonatomic) iBeaconItem *beaconInstance;
@property (strong, nonatomic) NSNumber *beaconInstanceIndex;
@property (nonatomic, strong) NSArray *beaconItems;

@end
