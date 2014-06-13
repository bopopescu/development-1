//
//  BDAppDelegate.h
//  BackgroundDemo
//
//  Created by David G. Young on 11/6/13.
//  Copyright (c) 2013 RadiusNetworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

//static NSString *const uuidKey = @"B9407F30-F5F8-466E-AFF9-25556B57FE6D";
//B9407F30-F5F8-466E-AFF9-25556B57FE6D

@interface BDAppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
