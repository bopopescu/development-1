//
//  PromoTestViewController.h
//  PromoTest
//
//  Created by Ray Wenderlich on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoTestViewController : UIViewController <UITextFieldDelegate> {
    
    UITextView *textView;
}
@property (nonatomic, retain) IBOutlet UITextView *textView;

@end
