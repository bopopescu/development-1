//
//  DHAPViewController.m
//  BeaconDetectorSimple
//
//  Created by Brian Sterner on 6/3/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import "iBeaconScanViewController.h"
#import "iBeaconConstants.h"
#import "iBeaconItem.h"
#import "iBeaconTableViewController.h"

NSString * const kRWTStoredItemsKey = @"storedUuids";

@interface iBeaconScanViewController ()
@end

@implementation iBeaconScanViewController

NSInteger beaconCount;

- (void)initializeScanner
{
    NSLog(@"--> iBeaconScanViewController initializeScanner STARTED");
    
    [self initBeaconScan];
    
    NSLog(@"<-- iBeaconScanViewController initializeScanner COMPLETED");
}

- (void) initBeaconScan
{
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSLog(@"Starting beacon scanner for UUID [%@]", ESTIMOTE_UUID);
    // Initialize the location manager, set deletegate to self
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:ESTIMOTE_UUID];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"Custom estimote region"];
     // only notify user if app display is on
    self.myBeaconRegion.notifyOnEntry = YES;
    self.myBeaconRegion.notifyOnExit = YES;
    self.myBeaconRegion.notifyEntryStateOnDisplay = YES;

    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];

    // Check if beacon monitoring is available for this device
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Monitoring not available" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]; [alert show]; return;
    } else {
        //[self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
        //NSLog(@"\tStarted searching for beacons...");
    }
}

/**
 * Activated when 'Scan' navigation button is clicked.  Starts scanning for iBeacons.
 */
-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    beaconCount = beacons.count;

    if (_beaconItems.count < beaconCount) {
        //NSLog(@"-->Entered didRangeBeacons()");
        
        //NSLog(@"Number of beacons found size is: %u", beaconCount);
        
        // Clear beacon display area
        NSMutableString *beaconInfo = [NSMutableString string];
        [beaconInfo setString:@""];

        NSLog(@"Populating beacon items array...");
        _beaconItems = [NSMutableArray array];
    
        for (CLBeacon *beacon in beacons) {
            CLProximity proximity = beacon.proximity;
            NSString *proximityValue = [self nameForProximity:proximity];
            NSString *displayUuid = beacon.proximityUUID.UUIDString;
            NSString *displayMajor = [NSString stringWithFormat:@"%@", beacon.major];
            NSString *displayMinor = [NSString stringWithFormat:@"%@", beacon.minor];
            NSString *displayLine = [NSString stringWithFormat:@"Beacon UUID: %@\nBeacon Major: %@\nBeacon: Minor: %@\nBeacon: Proximity: %@", displayUuid, displayMajor, displayMinor, proximityValue];
            [beaconInfo appendString:displayLine];
            
            if (self.isBeaconInfoDisplayEnabled) {
                //NSLog(@"Beacon Info [[\n%@\n]]", displayLine);
            } else {
                //NSLog(@"Beacon isBeaconDisplayEnabled = FALSE");
            }
            
            // Create new beacon item for storage
            iBeaconItem *beaconItem = [[iBeaconItem alloc] initWithName:displayUuid
                                                        uuid:beacon.proximityUUID
                                                       major:[displayMajor intValue]
                                                       minor:[displayMinor intValue]];
            // Serializes/encodes the object to be archived??
            //NSData *itemData = [NSKeyedArchiver archivedDataWithRootObject:newItem];
            [_beaconItems addObject:beaconItem];
        }

        if (self.tableView != nil) {
            NSLog(@"Number of sections in table view is [%ld]", (long)self.tableView.numberOfSections);
            [self.tableView reloadData];
        }
        
        //NSLog(@"Done populating beacon items array for first time.  Number of beacons found = [%ld]", (unsigned long)_beaconItems.count);
        //NSLog(@"--> didRangeBeacons() Completed");
    }
    
    NSLog(@"Beacon items array:  Number of beacons found = [%ld]", (unsigned long)_beaconItems.count);

    //[[NSUserDefaults standardUserDefaults] setObject:itemsDataArray forKey:kRWTStoredItemsKey];
    //NSArray *indexPathArray=[NSArray arrayWithObject:indexPath];
    //[self.tableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
}

// After monitoring start, request state for your defined region
- (void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    [self.locationManager requestStateForRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    if (state == CLRegionStateInside) {
        //Start Ranging
        [manager startRangingBeaconsInRegion:self.myBeaconRegion];
    } else {
        // Exited the region
        NSLog(@"State indicated we're no longer inside region.");
        [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
    }
}

- (NSString *)nameForProximity:(CLProximity)proximity {
    switch (proximity) {
        case CLProximityUnknown:
            return @"Unknown";
            break;
        case CLProximityImmediate:
            return @"Immediate";
            break;
        case CLProximityNear:
            return @"Near";
            break;
        case CLProximityFar:
            return @"Far";
            break;
    }
}

- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Beacon entered region!!");
    
    // We entered a region, now start looking for our target beacons!
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion *)region
{
    // Exited the region
    NSLog(@"Beacon EXITED region!!");
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}

/**
 * Initialize location manager for scanning
 */
- (void)scanForBeacons
{
    NSLog(@"--> scanForBeacons Entered");
    
    //[super viewDidLoad];

    /*
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Application started");
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                             identifier:@"Estimote Region"];
    // only notify user if app display is on
    self.myBeaconRegion.notifyOnEntry = YES;
    self.myBeaconRegion.notifyOnExit = YES;
    self.myBeaconRegion.notifyEntryStateOnDisplay = YES;

    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];

    
    // Check if beacon monitoring is available for this device
    if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Monitoring not available" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]; [alert show]; return;
    } else {
        [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
        self.statusLabel.text = @"Started searching for beacons!";
    }
    */
    
    NSLog(@"<-- scanForBeacons completed");
}

/**
 * Logs the currently stored items in user defaults
 * /
- (IBAction)displayStoredItems;
{
    NSLog(@"Stored items block entered");
    NSArray *storedItems = [[NSUserDefaults standardUserDefaults] arrayForKey:kRWTStoredItemsKey];
    NSLog(@"Stored items variable set ok");
    
    if ([storedItems isEqual:nil]) {
        NSLog(@"Stored items array size is NULL :((((");
        return;
    }
    
    NSInteger cnt = [storedItems count];
    NSLog(@"Stored items array size is: %u", cnt);
    
    NSData *storedItem = [storedItems firstObject];
    //DHAPItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:storedItem];
    
    for (NSData *itemData in storedItems) {
        DHAPItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:itemData];
        NSString *displayUuid = item.uuid.UUIDString;
        NSString *displayMajor = [NSString stringWithFormat:@"%hu", item.majorValue];
        NSString *displayMinor = [NSString stringWithFormat:@"%hu", item.minorValue];
        NSString *displayLine = [NSString stringWithFormat:@"Beacon UUID: %@\nBeacon Major: %@\nBeacon: Minor: %@\n\n", displayUuid, displayMajor, displayMinor];
        NSLog(@"Stored Item Info:\n%@", displayLine);
    }
}
*/

@end
