//
//  TicketTableViewCell.h
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "FavoriteMapPrice+CoreDataClass.h"

#define AirlineLogo(iata) [NSURL URLWithString:[NSString stringWithFormat:@"https://pics.avs.io/200/200/%@.png", iata]];

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavoriteTicket *favoriteTicket;
@property (nonatomic, strong) FavoriteMapPrice *favoriteMapPrice;
- (void)setFavoriteTicket:(FavoriteTicket *)favoriteTicket;
- (void)setFavoriteMapPrice:(FavoriteMapPrice *)favoriteMapPrice;

@end

