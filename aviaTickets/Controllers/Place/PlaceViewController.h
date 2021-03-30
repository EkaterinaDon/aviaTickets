//
//  PlaceViewController.h
//  aviaTickets
//
//  Created by Ekaterina on 7.03.21.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "City.h"
#import "Airport.h"
//#import "PlaceCell.h"
#import "PlaceCollectionCell.h"


typedef enum PlaceType {
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;

@protocol PlaceViewControllerDelegate <NSObject>
- (void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;
@end

@interface PlaceViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource> ///<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<PlaceViewControllerDelegate>delegate;
- (instancetype)initWithType:(PlaceType)type;

@end

