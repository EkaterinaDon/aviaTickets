//
//  AppDelegate.h
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "FirstViewController.h"
#import "NotificationCenter.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

