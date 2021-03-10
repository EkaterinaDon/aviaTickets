//
//  APIManager.h
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import "SearchRequest.h"
#import "Ticket.h"
#import "Feed.h"

#define AirlineLogo(iata) [NSURL URLWithString:[NSString stringWithFormat:@"https://pics.avs.io/200/200/%@.png", iata]];

@interface APIManager : NSObject

+ (instancetype)sharedInstance;
- (void)cityForCurrentIP:(void (^)(City *city))completion;
- (void)ticketsWithRequest:(SearchRequest)request withCompletion:(void (^)(NSArray *tickets))completion;
- (void)feedsWithRequest:(NSString*)searchString withCompletion:(void (^)(NSArray *feeds))completion;

@end

