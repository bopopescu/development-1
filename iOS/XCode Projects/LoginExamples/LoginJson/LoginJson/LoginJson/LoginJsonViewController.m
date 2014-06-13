//
//  LoginJsonViewController.m
//  LoginJson
//
//  Created by Brian Sterner on 6/13/14.
//  Copyright (c) 2014 DHAP Digital Inc. All rights reserved.
//

#import "LoginJsonViewController.h"

@interface LoginJsonViewController ()
@end

@implementation LoginJsonViewController

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

- (IBAction)doLoginUser {
    [self doBeginLogin:_usernameField.text password:_pswdField.text];
}


- (BOOL)doBeginLogin:(NSString *)username password:(NSString *)password {
    @try {
        
        if (username && password && username.length != 0 && password.length != 0) {
            NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@", username, password];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://dipinkrishna.com/jsonlogin.php"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:urlData
                                                                         options:0
                                                                           error:NULL];
                NSInteger responseCode = [[greeting objectForKey:@"success"] integerValue];
                
                NSLog(@"Response success code = [ %ld ]", (long)responseCode);
 
                [self loadLoginSuccessfulViewController:responseCode];
                /*
                SBJsonParser *jsonParser = [SBJsonParser new];
                NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                NSLog(@"%@",jsonData);
                NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                NSLog(@"%d",success);
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                    [self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    
                } else {
                    
                    NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:error_msg :@"Login Failed!"];
                }
                */
            } else {
                if (error) NSLog(@"Error: %@", error);
                //[self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        //[self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

-(void)loadLoginSuccessfulViewController:(NSInteger) isSuccess {
    NSString *seque = isSuccess == 1 ? @"sequeLoginSuccessful" : @"sequeLoginFailure";
    [self performSegueWithIdentifier:seque sender:nil];
}

@end
