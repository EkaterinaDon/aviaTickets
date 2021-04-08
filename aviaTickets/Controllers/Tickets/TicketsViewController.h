//
//  TicketsViewController.h
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import <UIKit/UIKit.h>
#import "TicketTableViewCell.h"
#import "CoreDataHelper.h"
#import "NotificationCenter.h"
#import "NSString+Localization.h"


@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;
- (instancetype)initFavoriteTicketsController;

@end

