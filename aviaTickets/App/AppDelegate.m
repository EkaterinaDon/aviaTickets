//
//  AppDelegate.m
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame: windowFrame];
    
    FirstViewController *firstViewController = [[FirstViewController alloc] init];
    
    self.window.rootViewController = firstViewController;
    [self.window makeKeyAndVisible];
    
    [[NotificationCenter sharedInstance] registerService];
    return YES;
}


@end
