//
//  DHPUViewController.h
//  PunchUp
//
//  Created by Brian Sterner on 6/9/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHPUViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableViewCell *cellOne;
@property (nonatomic, strong) IBOutlet UITableViewCell *cellTwo;

@end
