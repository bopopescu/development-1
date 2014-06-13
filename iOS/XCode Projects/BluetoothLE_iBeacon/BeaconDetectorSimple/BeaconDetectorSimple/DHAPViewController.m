//
//  DHAPViewController.m
//  BeaconDetectorSimple
//
//  Created by Brian Sterner on 6/3/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import "DHAPViewController.h"
#import "DHAPItem.h"

NSString * const kRWTStoredItemsKey = @"storedUuids";

@interface DHAPViewController ()
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation DHAPViewController

- (IBAction)fetchGreeting;
{
    NSURL *url = [NSURL URLWithString:@"http://rest-service.guides.spring.io/greeting"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
             self.greetingContent.text = [greeting objectForKey:@"content"];
         }
     }];
}

/**
 * ==========================================================================================================
 * ====================================== MAIN BEACON RANGING FUNCTION ======================================
 */
-(void)locationManager:(CLLocationManager*)manager
       didRangeBeacons:(NSArray*)beacons
              inRegion:(CLBeaconRegion*)region
{
    NSLog(@"Beacon found!!!");

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
    
    // Clear message if beacons found
    if (count > 0) {
        [beaconInfo setString:@""];
    }

    // Used to store objects
    NSMutableArray *itemsDataArray = [NSMutableArray array];

    for (CLBeacon *beacon in beacons) {
        CLProximity proximity = beacon.proximity;
        NSString *proximityValue = [self nameForProximity:proximity];
        NSString *displayUuid = beacon.proximityUUID.UUIDString;
        NSString *displayMajor = [NSString stringWithFormat:@"%@", beacon.major];
        NSString *displayMinor = [NSString stringWithFormat:@"%@", beacon.minor];
        NSString *displayLine = [NSString stringWithFormat:@"Beacon UUID: %@\nBeacon Major: %@\nBeacon: Minor: %@\nBeacon: Proximity: %@\n\n", displayUuid, displayMajor, displayMinor, proximityValue];
        [beaconInfo appendString:displayLine];
        NSLog(@"%@", displayLine);

        
        NSInteger itemCount = self.items.count;
        DHAPItem *newItem = [[DHAPItem alloc] initWithName:displayUuid
                                                    uuid:beacon.proximityUUID
                                                   major:[displayMajor intValue]
                                                   minor:[displayMinor intValue]];

        // Serializes/encodes the object to be archived??
        NSData *itemData = [NSKeyedArchiver archivedDataWithRootObject:newItem];
        [itemsDataArray addObject:itemData];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:itemsDataArray forKey:kRWTStoredItemsKey];
    
    NSInteger cnt = [itemsDataArray count];
    NSLog(@"itemsDataArrary size is: %u", cnt);
    
    // Set text area value using the beacon info string we just built
    self.dynamicLabel.text = beaconInfo;
}
// =========================================================================================================

/**
 * After monitoring start, request state for your defined region
 */
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
        NSLog(@"State indicated we're no longer in regision.");
        self.statusLabel.text = @"None found.";
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
    self.statusLabel.text = @"Finding beacons.";
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}

-(void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion *)region
{
    // Exited the region
    NSLog(@"Beacon EXITED region!!");
    self.statusLabel.text = @"None found.";
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

    NSLog(@"viewDidLoaded completed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Logs the currently stored items in user defaults
 */
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
    //    //self.items = [NSMutableArray array];
    //
    //    if (storedItems) {
    //        /*
    //         for (NSData *itemData in storedItems) {
    //            DHAPItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:itemData];
    //            //[self.items addObject:item];
    //            //[self startMonitoringItem:item];
    //            NSString *displayUuid = [NSString stringWithFormat:@"%@", item.uuid.UUIDString];
    //            NSString *displayMajor = [NSString stringWithFormat:@"%hu", item.majorValue];
    //            NSString *displayMinor = [NSString stringWithFormat:@"%hu", item.minorValue];
    //            NSLog(@"Stored Item Info: [%@]; [%@]; [%@]", displayMajor, displayMinor, displayUuid);
    //        }
    //        */
    //    }
}

@end

// ==========================================================================================================================
// ======================================================= Saved code =======================================================
// Persist beacon info in user defaults
//NSArray *storedItems = [[NSUserDefaults standardUserDefaults] arrayForKey:kRWTStoredItemsKey];
//self.items = [NSMutableArray array];

//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newItem];
//        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kRWTStoredItemsKey];
//        NSInteger userDefault = [NSUserDefaults standardUserDefaults:count];
//for (RWTItem *item in self.items) {

//        if (itemCount > 0) {
//            //        for (DHAPItem *item in self.items) {
//            //            if ([item isEqualToCLBeacon:beacon]) {
//            //                NSLog(@"Found matching beacon with major:minor values [%@:%@]", displayMajor, displayMinor);
//            //                item.lastSeenBeacon = beacon;
//            //            } else {
//            //                NSLog(@"Adding beacon with major:minor values [%@:%@]", displayMajor, displayMinor);
//            //            }
//            //        }
//        } else {
//            NSLog(@"Adding beacon with major:minor values [%@:%@]", displayMajor, displayMinor);
//            [self.items addObject:newItem];
//        }
// ==========================================================================================================================
