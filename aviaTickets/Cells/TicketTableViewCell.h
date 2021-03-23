//
//  TicketTableViewCell.h
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;

@end

NS_ASSUME_NONNULL_END
