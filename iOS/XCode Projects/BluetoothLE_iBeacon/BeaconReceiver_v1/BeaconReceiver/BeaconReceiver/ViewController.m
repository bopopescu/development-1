//
//  ViewController.m
//  BeaconReceiver
//
//  Created by Christopher Ching on 2013-11-28.
//  Copyright (c) 2013 AppCoda. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *resources;
//@property (strong, nonatomic, readwrite) NSUUID *uuid;
//@property (strong, nonatomic, readwrite) NSArray *cats;

@end

@implementation ViewController

/**
 The above delegate method is called when iBeacons come within range, move out of range, or when the range of an iBeacon changes.
 */
-(void)locationManager:(CLLocationManager*)
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    // Beacon found!
    self.statusLabel.text = @"Beacon found!";
    self.dynamicLabel.text = @"GOOD WORK NOW TRY TO GET THE UUID INFO";
    //self.uuidLabel.text = @"The correct beacon technical info should be displayed here";
    
    // This should provide reference in the beacons that we're found
    CLBeacon *foundBeacon = [beacons firstObject];
    NSString *firstBeaconUuidLabel = [NSString stringWithFormat:@"%@", foundBeacon.proximityUUID.UUIDString];
    //self.uuidLabel.text = firstBeaconUuidLabel;
    
    NSInteger count = [beacons count];
    NSString *countLabel = [NSString stringWithFormat:@"%ld", (long)count];
    self.beaconCount.text = countLabel;

    // Clear beacon display area
    NSMutableString *beaconInfo = [NSMutableString string];
    [beaconInfo setString:@""];
    self.dynamicLabel.text = beaconInfo;

    // Now try to cycle through the list of beacons and print out their information
    CLBeacon *beacon = nil;
    
    // Clear message if beacons found
    if (count > 0) {
        [beaconInfo setString:@""];
    }
    
    for (int i = 0; i < count; i++) {
        beacon = [beacons objectAtIndex:i];
        CLProximity proximity = beacon.proximity;
        NSString *displayUuid = beacon.proximityUUID.UUIDString;
        NSString *displayMajor = [NSString stringWithFormat:@"%@", beacon.major];
        NSString *displayMinor = [NSString stringWithFormat:@"%@", beacon.minor];
        [beaconInfo appendString:[NSString stringWithFormat:@"Beacon UUID: %@\r\nBeacon Major: %@\r\nBeacon: Minor: %@:\r\n\r\n", displayUuid, displayMajor, displayMinor]];
    }
    
    self.dynamicLabel.text = beaconInfo;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize location manager and set ourselves as the delegate
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
//    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
//                                                             identifier:@"com.appcoda.testregion"];
    
    
    
    // See this for question regarding use of "identifier" property: http://stackoverflow.com/questions/20562257/ibeacon-difference-between-proximityuuid-and-region-identifier
    // CLBeaconRegion *region1 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 1 identifier: @"my.made.up.unique.identifer];
    // [_locationManager startMonitoringForRegion:region1];
    // CLBeaconRegion *region2 = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 2 identifier: @"my.made.up.unique.identifer];
    // [_locationManager startMonitoringForRegion:region2];
    // This is most commonly used to stop monitoring for a region. Like this:
    // CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6"] major: 1 minor: 1 identifier: @"another.made.up.unique.identifer];
    //                          [_locationManager startMonitoringForRegion:region];
    // ...
    // [_locationManager stopMonitoringForRegion:region];
                                                          
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"Estimote Region"];
    // only notify user if app display is on
    self.myBeaconRegion.notifyEntryStateOnDisplay = YES;
    self.myBeaconRegion.notifyOnEntry = NO;
    self.myBeaconRegion.notifyOnExit = NO;
    
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    
    // NOTE: There is a startRangingBeaconsInRegion method which will report events on a specific beacon region with regards to movement (range changes)
    
    // Check if beacon monitoring is available for this device
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Monitoring not available" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]; [alert show]; return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion *)region
{
    // We entered a region, now start looking for our target beacons!
    self.statusLabel.text = @"Finding beacons.";
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion *)region
{
    // Exited the region
    self.statusLabel.text = @"None found.";
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}


@end
