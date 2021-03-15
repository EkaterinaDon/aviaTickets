//
//  LocationService.h
//  aviaTickets
//
//  Created by Ekaterina on 14.03.21.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kLocationServiceDidUpdateCurrentLocation @"LocationServiceDidUpdateCurrentLocation"

@interface LocationService : NSObject

- (void)start;

@end
