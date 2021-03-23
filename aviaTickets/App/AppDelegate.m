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
    
//    ViewController *viewController = [[ViewController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
    TabBarController *tabBarController = [[TabBarController alloc] init];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
