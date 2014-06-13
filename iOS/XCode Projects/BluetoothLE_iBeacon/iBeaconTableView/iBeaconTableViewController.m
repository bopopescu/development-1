//
//  CarTableViewController.m
//  TableViewStory
//
//  Created by Brian Sterner on 6/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import "iBeaconTableViewController.h"
#import "iBeaconTableViewCell.h"
#import "iBeaconDetailViewController.h"
#import "iBeaconScanViewController.h"
#import "iBeaconConstants.h"
#import "iBeaconItem.h"
#import "UIImageResizing.h"
#import "iBeaconPersistanceManager.h"

iBeaconPersistanceManager *persistanceManager;

@interface iBeaconTableViewController ()
@end

@implementation iBeaconTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]];         
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize location manager
    [self initLocationManager];
    //[self initPersistanceManager];
    [self initCars];
    
    self.beaconScanManager.isBeaconInfoDisplayEnabled = false;
    self.beaconScanManager.tableView = self.tableView;
    //[self testDataStructures];
}

- (void) initPersistanceManager
{
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"--> initPersistanceManager Started");
    
    // Create new persistance manager used to save/store beacon info
    persistanceManager = [[iBeaconPersistanceManager alloc] init];
    
    NSLog(@"<-- initPersistanceManager Completed");
}


- (void) initLocationManager
{
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"--> initLocationManager Started");
    
    self.beaconScanManager = [[iBeaconScanViewController alloc] init];
    [self.beaconScanManager initializeScanner];
    
    NSLog(@"<-- initLocationManager Completed");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) reloadTableCells
{
    NSLog(@"Reload beacon action clicked");
    
    // View/load stored beacon items
    //for (iBeaconItem *beacon in _beaconItems) {
    //}
    
    [self.tableView reloadData];
}

- (void) initCars
{
    NSLog(@"--> Creating car arrays BEGIN");
    
    // Added data to populate table view cells
    _carMakes = @[@"Chevy",
                  @"BMW",
                  @"Toyota",
                  @"Volvo",
                  @"Smart"];
    
    _carModels = @[@"Volt",
                   @"Mini",
                   @"Venza",
                   @"S60",
                   @"Fortwo"];
    
    _carImages = @[@"chevy_volt.jpg",
                   @"mini_clubman.jpg",
                   @"toyota_venza.jpg",
                   @"volvo_s60.jpg",
                   @"smart_fortwo.jpg"];
    
    NSLog(@"--> Creating car arrays COMPLETED");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSInteger numTableRows = _carModels.count;
    NSInteger numBeaconsFound = self.beaconScanManager.beaconItems.count;
    
    if (numBeaconsFound > 0) {
        numTableRows = numBeaconsFound;
    }
    
    NSLog(@"Number of table view cells is [%ld] while size of beacon item array is [%ld]", (unsigned long)numTableRows,  (unsigned long)numBeaconsFound);
    
    return numTableRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"--> cellForRowAtIndexPath called, loading table cells...");

    static NSString *CellIdentifier = @"carTableCell";
    iBeaconTableViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier
                              forIndexPath:indexPath];
    
    // Configure the cell...
    
    long row = [indexPath row];
    
    NSArray *beacons = self.beaconScanManager.beaconItems;
    
    NSString *modelLabel;
    NSString *makeLabel;
    NSString *carImageLabel;
    
    if (beacons.count > 0) {
        iBeaconItem *beacon = self.beaconScanManager.beaconItems[row];
        //NSString *proximityValue = [self nameForProximity:proximity];
        NSString *displayUuid = beacon.uuid.UUIDString;
        NSString *displayMajor = [NSString stringWithFormat:@"%hu", beacon.majorValue];
        NSString *displayMinor = [NSString stringWithFormat:@"%hu", beacon.minorValue];
        makeLabel = displayUuid;
        modelLabel = [NSString stringWithFormat:@"%@ :: %@", displayMajor, displayMinor];
        carImageLabel = @"scan_icon.jpg";
    } else {
        modelLabel = _carModels[row];
        makeLabel = _carMakes[row];
        carImageLabel = _carImages[row];
    }

    cell.modelLabel.text = modelLabel;
    cell.makeLabel.text = makeLabel;
    cell.carImage.image = [UIImage imageNamed:carImageLabel];
    
    // Resize image
    UIImage* image = [UIImage imageNamed:carImageLabel];
    UIImage* smallImage = [image scaleToSize:CGSizeMake(82.0f,82.0f)];
    cell.carImage.image = smallImage;

    NSLog(@"<-- cellForRowAtIndexPath COMPLETED");

    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowCarDetails"])
    {
        iBeaconDetailViewController *detailViewController = [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        
        iBeaconItem *beacon = self.beaconScanManager.beaconItems[row];
        NSString *displayUuid = beacon.uuid.UUIDString;
        NSString *displayMajor = [NSString stringWithFormat:@"%hu", beacon.majorValue];
        NSString *displayMinor = [NSString stringWithFormat:@"%hu", beacon.minorValue];
        
        NSString *modelLabel;
        NSString *makeLabel;
        NSString *carImageLabel;
        makeLabel = displayUuid;
        modelLabel = [NSString stringWithFormat:@"%@ :: %@", displayMajor, displayMinor];
        carImageLabel = @"scan_icon.jpg";
        
        NSArray *beacons = self.beaconScanManager.beaconItems;

        detailViewController.carDetailModel = @[makeLabel,
                                                modelLabel, carImageLabel];
        detailViewController.beaconInstanceIndex = [NSNumber numberWithLong:row];
        detailViewController.beaconInstance = beacons[row];
        detailViewController.beaconItems = self.beaconScanManager.beaconItems;
        
        /*
        detailViewController.carDetailModel = @[_carMakes[row],
                                                _carModels[row], _carImages[row]];
         */
    }
}

// ===========================================================================================================================================================
//
// Temp debug functions
//
// ===========================================================================================================================================================

- (void) testDataStructures {
    // Literal syntax
    NSDictionary *inventory = @{
                                @"Mercedes-Benz SLK250" : [NSNumber numberWithInt:13],
                                @"Mercedes-Benz E350" : [NSNumber numberWithInt:22],
                                @"BMW M3 Coupe" : [NSNumber numberWithInt:19],
                                @"BMW X6" : [NSNumber numberWithInt:16],
                                };
    // Values and keys as arguments
    inventory = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSNumber numberWithInt:13], @"Mercedes-Benz SLK250",
                 [NSNumber numberWithInt:22], @"Mercedes-Benz E350",
                 [NSNumber numberWithInt:19], @"BMW M3 Coupe",
                 [NSNumber numberWithInt:16], @"BMW X6", nil];
    // Values and keys as arrays
    NSArray *models = @[@"Mercedes-Benz SLK250", @"Mercedes-Benz E350",
                        @"BMW M3 Coupe", @"BMW X6"];
    NSArray *stock = @[[NSNumber numberWithInt:13],
                       [NSNumber numberWithInt:22],
                       [NSNumber numberWithInt:19],
                       [NSNumber numberWithInt:16]];
    inventory = [NSDictionary dictionaryWithObjects:stock forKeys:models];
    NSLog(@"%@", inventory);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
