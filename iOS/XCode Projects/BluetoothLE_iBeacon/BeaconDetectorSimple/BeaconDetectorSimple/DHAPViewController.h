//
//  DHAPViewController.h
//  BeaconDetectorSimple
//
//  Created by Brian Sterner on 6/3/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DHAPViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) CLBeaconRegion *myBeaconRegion;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dynamicLabel;
//@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *beaconCount;
@property (weak, nonatomic) IBOutlet UITextView *uiTextView;

// Stored items text area
@property (weak, nonatomic) IBOutlet UILabel *storedItemLabel;

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;

- (IBAction)fetchGreeting;
- (IBAction)displayStoredItems;

@end
