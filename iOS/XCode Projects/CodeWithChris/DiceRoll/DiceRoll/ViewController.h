//
//  ViewController.h
//  DiceRoll
//
//  Created by Christopher Ching on 2013-09-19.
//  Copyright (c) 2013 CodeWithChris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DieView.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *sumLabel;
@property (strong, nonatomic) IBOutlet DieView *secondDieView;
@property (strong, nonatomic) IBOutlet DieView *firstDieView;
@property (strong, nonatomic) IBOutlet UIButton *rollButton;

@end
