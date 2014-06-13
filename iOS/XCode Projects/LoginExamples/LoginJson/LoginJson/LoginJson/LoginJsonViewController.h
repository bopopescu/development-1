//
//  LoginJsonViewController.h
//  LoginJson
//
//  Created by Brian Sterner on 6/13/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginJsonViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
- (IBAction)doLoginUser;
@property (weak, nonatomic) IBOutlet UITextField *pswdField;

@end
