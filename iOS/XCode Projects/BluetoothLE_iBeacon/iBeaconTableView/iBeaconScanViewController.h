//
//  DHAPViewController.h
//  BeaconDetectorSimple
//
//  Created by Brian Sterner on 6/3/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface iBeaconScanViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic,retain) UITableView *tableView;

// Used to store iBeacon instances
@property (strong, nonatomic) NSMutableArray *beaconItems;

@property Boolean isBeaconInfoDisplayEnabled;

- (void)initializeScanner;

//- (IBAction)scanForBeacons;

@end
