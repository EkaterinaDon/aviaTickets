//
//  TicketsViewController.h
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import <UIKit/UIKit.h>
#import "TicketTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;

@end

NS_ASSUME_NONNULL_END
