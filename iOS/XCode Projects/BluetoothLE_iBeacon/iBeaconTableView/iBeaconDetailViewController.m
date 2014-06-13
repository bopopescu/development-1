//
//  CarDetailViewController.m
//  TableViewStory
//
//  Created by Brian Sterner on 6/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import "iBeaconDetailViewController.h"
#import "iBeaconPersistanceManager.h"
#import "iBeaconItem.h"

iBeaconPersistanceManager *persistanceManager;

@interface iBeaconDetailViewController ()

@end

@implementation iBeaconDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    [self initPersistanceManager];

    _makeLabel.text = _carDetailModel[0];
    _modelLabel.text = _carDetailModel[1];
    _imageView.image = [UIImage imageNamed:_carDetailModel[2]];
    
    // Used passed in reference or beacon instance number to retrieve info
    NSLog(@"Beacon instance index: %@", _beaconInstanceIndex);
    NSLog(@"Beacon instance detail info: %@, %hu, %hu", _beaconInstance.uuid.UUIDString, _beaconInstance.majorValue, _beaconInstance.minorValue);
    
    NSLog(@"Checking existence of beacon instance....");
    
    if ([_beaconItems containsObject:_beaconInstance]) {
        NSLog(@"====> Beacon instance was found.  It should be since we passed in an item that's in the array");
    }
}

- (void) functionWithArguments:(NSString *) someString arbitraryArgumentLabel:(NSNumber *) someNumber
{
    
}

- (void) initPersistanceManager
{
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"--> initPersistanceManager Started");
    
    // Create new persistance manager used to save/store beacon info
    persistanceManager = [[iBeaconPersistanceManager alloc] init];
    
    NSLog(@"<-- initPersistanceManager Completed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveBeacon {
    NSLog(@"Checking existence of beacon instance....");
    
    if ([_beaconItems containsObject:_beaconInstance]) {
        NSLog(@"====> Beacon instance was found.  It should be since we passed in an item that's in the array");
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
