#import "MyTabViewAppDelegate.h"

@implementation MyTabViewAppDelegate

@synthesize tabBarController;
@synthesize firstViewController, secondViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //create the view controller for the first tab
    self.firstViewController = [[FirstViewController alloc] initWithNibName:nil
                                                                     bundle:NULL];
    
    //create the view controller for the second tab
    self.secondViewController = [[SecondViewController alloc] initWithNibName:nil
                                                                       bundle:NULL];
    
    //create an array of all view controllers that will represent the tab at the bottom
    NSArray *myViewControllers = [[NSArray alloc] initWithObjects:
                                  self.firstViewController,
                                  self.secondViewController, nil];
    
    //initialize the tab bar controller
    self.tabBarController = [[MyUITabBarController alloc] init];
    
    //set the view controllers for the tab bar controller
    [self.tabBarController setViewControllers:myViewControllers];
    
    //add the tab bar controllers view to the window
    [self.window addSubview:self.tabBarController.view];
    
    //set the window background color and make it visible
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //do nothing
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //do nothing
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //do nothing
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //do nothing
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //do nothing
}

@end