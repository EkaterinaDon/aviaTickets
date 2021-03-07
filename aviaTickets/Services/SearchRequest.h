//
//  SearchRequest.h
//  aviaTickets
//
//  Created by Ekaterina on 7.03.21.
//

#import <Foundation/Foundation.h>

typedef struct SearchRequest {
    __unsafe_unretained NSString *origin;
    __unsafe_unretained NSString *destionation;
    __unsafe_unretained NSDate *departDate;
    __unsafe_unretained NSDate *returnDate;
} SearchRequest;
