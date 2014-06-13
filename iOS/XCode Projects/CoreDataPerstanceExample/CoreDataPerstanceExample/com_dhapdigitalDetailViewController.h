//
//  com_dhapdigitalDetailViewController.h
//  CoreDataPerstanceExample
//
//  Created by Brian Sterner on 5/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface com_dhapdigitalDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
