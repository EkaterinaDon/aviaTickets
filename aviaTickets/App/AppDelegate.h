//
//  AppDelegate.h
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

