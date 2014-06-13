//
//  CarTableViewController.h
//  TableViewStory
//
//  Created by Brian Sterner on 6/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBeaconScanViewController.h"

@interface iBeaconTableViewController : UITableViewController

@property (strong, nonatomic) iBeaconScanViewController *beaconScanManager;
@property (nonatomic, strong) NSArray *carImages;
@property (nonatomic, strong) NSArray *carMakes;
@property (nonatomic, strong) NSArray *carModels;

// Used to store iBeacon instances
//@property NSMutableArray *beaconItems;

- (IBAction) reloadTableCells;

@end
