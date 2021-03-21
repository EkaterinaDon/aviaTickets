//
//  CoreDataHelper.h
//  aviaTickets
//
//  Created by Ekaterina on 20.03.21.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "FavoriteMapPrice+CoreDataClass.h"
#import "Ticket.h"
#import "MapPrice.h"

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(Ticket *)ticket;
- (NSArray *)favorites;
- (void)addToFavorite:(Ticket *)ticket;
- (void)removeFromFavorite:(Ticket *)ticket;
- (BOOL)isFavoriteMapPrice:(MapPrice *)mapPrice;
- (void)addToFavoriteMapPrice:(MapPrice *)mapPrice;
- (void)removeFromFavoriteMapPrice:(MapPrice *)mapPrice;
- (NSArray *)favoriteMapPrices;

@end


