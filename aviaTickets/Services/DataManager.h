//
//  DataManager.h
//  aviaTickets
//
//  Created by Ekaterina on 3.03.21.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "Country.h"
#import "Airport.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    DataSourceTypeCountry,
    DataSourceTypeCity,
    DataSourceTypeAirport
} DataSourceType;

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

+ (instancetype)sharedInstance;
- (void)loadData;
- (City *)cityForIATA:(NSString *)iata;

@property (nonatomic, strong, readonly) NSArray *countries;
@property (nonatomic, strong, readonly) NSArray *cities;
@property (nonatomic, strong, readonly) NSArray *airports;

@end

NS_ASSUME_NONNULL_END
