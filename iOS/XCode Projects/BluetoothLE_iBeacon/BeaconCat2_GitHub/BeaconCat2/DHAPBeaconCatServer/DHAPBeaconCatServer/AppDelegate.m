//
//  AppDelegate.m
//  DHAPBeaconCatServer
//
//  Created by Kevin Kim on 5/6/14.
//  Copyright (c) 2014 DHAP Digital. All rights reserved.
//

#import "AppDelegate.h"

#import <IOBluetooth/IOBluetooth.h>
#import "DHAPBeaconCatLibrary/DHAPBeaconCatLibrary.h"
#import "BLCBeaconAdvertisementData.h"


@interface AppDelegate () <CBPeripheralManagerDelegate, NSTextFieldDelegate>

@property (nonatomic, strong) CBPeripheralManager *manager;

@property (nonatomic, strong) NSArray *cats;
@property (nonatomic, strong) DHAPBeaconCat *selectedCat;
@property (weak) IBOutlet NSArrayController *catsController;


@property (weak) IBOutlet NSTextField *uuidTextField;
@property (weak) IBOutlet NSPopUpButtonCell *catPopUpButton;

@property (weak) IBOutlet NSTextField *majorValueTextField;
@property (weak) IBOutlet NSTextField *minorValueTextField;
@property (weak) IBOutlet NSTextField *measuredPowerTextField;
@property (weak) IBOutlet NSButton *broadcastingButton;

- (IBAction)changeSelection:(id)sender;

- (IBAction)broadcastingButtonPressed:(id)sender;
- (void)_startBroadcasting:(NSButton *)button;
- (void)_stopBroadcasting:(NSButton *)button;
@end


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.cats = [[DHAPBeaconCatManager sharedInstance] cats];
    self.manager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    [self.broadcastingButton setEnabled:NO];
    NSString *str = [[[DHAPBeaconCatManager sharedInstance] uuid] UUIDString];
    if ( str ) {
        [self.uuidTextField setStringValue:str];
    }
    
    NSUInteger selectedIndex = 0;
    [self.catPopUpButton selectItemAtIndex:selectedIndex];
    [self.catPopUpButton synchronizeTitleAndSelectedItem];
    self.selectedCat = self.cats[selectedIndex];
    [self _updateMajorMinor];
}

- (void)_updateMajorMinor
{
    self.majorValueTextField.stringValue = [self.selectedCat.major stringValue];
    self.minorValueTextField.stringValue = [self.selectedCat.minor stringValue];
}

- (IBAction)changeSelection:(id)sender
{
    [self _updateMajorMinor];
    if (self.manager.isAdvertising) {
        [self _stopBroadcasting:self.broadcastingButton];
        [self _startBroadcasting:self.broadcastingButton];
    }
}

- (IBAction)broadcastingButtonPressed:(id)sender
{
    NSButton *broadcastButton = (NSButton *)sender;
    if (self.manager.isAdvertising) {
        [self _stopBroadcasting:broadcastButton];
    }
    else {
        [self _startBroadcasting:broadcastButton];
    }
}

- (void)_startBroadcasting:(NSButton *)button
{
    NSUUID *uuid = [[DHAPBeaconCatManager sharedInstance] uuid];
    BLCBeaconAdvertisementData *beaconData = [[BLCBeaconAdvertisementData alloc] initWithProximityUUID:uuid
                                                                                                 major:self.majorValueTextField.integerValue
                                                                                                 minor:self.minorValueTextField.integerValue
                                                                                         measuredPower:self.measuredPowerTextField.integerValue];
    
    
    [self.manager startAdvertising:beaconData.beaconAdvertisement];
    [self.uuidTextField setEnabled:NO];
    [self.majorValueTextField setEnabled:NO];
    [self.minorValueTextField setEnabled:NO];
    [self.measuredPowerTextField setEnabled:NO];
    
    [button setTitle:@"Stop Broadcasting iBeacon"];
}

- (void)_stopBroadcasting:(NSButton *)button
{
    [self.manager stopAdvertising];
    [self.uuidTextField setEnabled:YES];
    [self.majorValueTextField setEnabled:YES];
    [self.minorValueTextField setEnabled:YES];
    [self.measuredPowerTextField setEnabled:YES];

    [button setTitle:@"Start Broadcasting iBeacon"];
}

#pragma mark - CBPeripheralManagerDelegate Methods

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        [self.broadcastingButton setEnabled:YES];
        [self.uuidTextField setEnabled:YES];
        [self.majorValueTextField setEnabled:YES];
        [self.minorValueTextField setEnabled:YES];
        [self.measuredPowerTextField setEnabled:YES];
        self.uuidTextField.delegate = self;
    }
}

#pragma mark - NSTextFieldDelegate Methods

- (BOOL)control:(NSControl *)control textShouldEndEditing:(NSText *)fieldEditor
{
    return YES;
}

@end
