#import <UIKit/UIKit.h>

#import "MyUITabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface MyTabViewAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyUITabBarController *tabBarController;

@property (strong, nonatomic) FirstViewController *firstViewController;
@property (strong, nonatomic) SecondViewController *secondViewController;

@end
