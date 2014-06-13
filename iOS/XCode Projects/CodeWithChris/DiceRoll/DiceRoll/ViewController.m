//
//  ViewController.m
//  DiceRoll
//
//  Created by Christopher Ching on 2013-09-19.
//  Copyright (c) 2013 CodeWithChris. All rights reserved.
//

#import "ViewController.h"
#import "DiceDataController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rollClicked:(id)sender {
    
    DiceDataController *diceDataController = [[DiceDataController alloc] init];
    
    int firstNumber = [diceDataController getDieNumber];
    int secondNumber = [diceDataController getDieNumber];
    
    [self.firstDieView showDieNumber:firstNumber];
    [self.secondDieView showDieNumber:secondNumber];
    
    self.sumLabel.text = [NSString stringWithFormat:@"The sum is %d", firstNumber + secondNumber];
}
@end
