//
//  ViewController.h
//  LoginScreenTutorial
//
//  Created by Dipin Krishna on 26/12/13.
//  Copyright (c) 2013 Dipin Krishna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)sigininClicked:(id)sender;

- (IBAction)backgroundTap:(id)sender;
@end
