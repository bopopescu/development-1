//
//  DHAPDetailViewController.h
//  BeaconDetector
//
//  Created by Brian Sterner on 6/3/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHAPDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
