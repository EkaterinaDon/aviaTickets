//
//  MapViewController.m
//  aviaTickets
//
//  Created by Ekaterina on 14.03.21.
//

#import "MapViewController.h"
#import "LocationService.h"
#import "APIManager.h"

@interface MapViewController () <MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@property (nonatomic, strong) LocationService *locationService;
@property (nonatomic, strong) City *origin;
@property (nonatomic, strong) NSArray *prices;

- (void)getMapPriceBy:(NSString *)title;
- (void) showAddToFavoriteAlert:(MapPrice *) mapPrice;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"mapTitle".localize;
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    [[DataManager sharedInstance] loadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.locationService start];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dataLoadedSuccessfully {
    self.locationService = [[LocationService alloc] init];
    [self.locationService start];
}

- (void)updateCurrentLocation:(NSNotification *)notification {
    CLLocation *currentLocation = notification.object;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
    [self.mapView setRegion: region animated: YES];
    
    if (currentLocation) {
        self.origin = [[DataManager sharedInstance] cityForLocation:currentLocation];
        if (self.origin) {
            [[APIManager sharedInstance] mapPricesFor:self.origin withCompletion:^(NSArray *prices) {
                self.prices = prices;
            }];
        }
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if ([placemarks count] > 0) {
            for (MKPlacemark *placemark in placemarks) {
                [self.mapView removeAnnotations: self.mapView.annotations];
                dispatch_async(dispatch_get_main_queue(), ^{
                    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                    annotation.title = [NSString stringWithFormat:@"%@", placemark.locality];
                    [self->_mapView addAnnotation: annotation];
                });
            }
        }
    }];
    
}

- (void)setPrices:(NSArray *)prices {
    _prices = prices;
    [self.mapView removeAnnotations: self.mapView.annotations];
    
    for (MapPrice *price in prices) {
        dispatch_async(dispatch_get_main_queue(), ^{
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            annotation.title = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
            annotation.subtitle = [NSString stringWithFormat:@"%ld руб.", (long)price.value];
            annotation.coordinate = price.destination.coordinate;
            [self->_mapView addAnnotation: annotation];
        });
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    [mapView deselectAnnotation:view.annotation animated:YES];

    if ([view.annotation isKindOfClass:[MKUserLocation class]]) {
        return;
    }
    [self getMapPriceBy:view.annotation.title];
    
}


- (void)getMapPriceBy:(NSString *)title {
    NSString *priceTitle = @"";
    
    for (MapPrice *price in self.prices) {
        priceTitle = [NSString stringWithFormat:@"%@ (%@)", price.destination.name, price.destination.code];
        if ([priceTitle isEqualToString:title]) {
            [self showAddToFavoriteAlert:price];
            break;
        }
    }
}

- (void) showAddToFavoriteAlert:(MapPrice *) mapPrice {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"actionsWithTickets".localize message:@"actionsWithTicketsDescription".localize preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    
    if ([[CoreDataHelper sharedInstance] isFavoriteMapPrice:mapPrice]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"removeFromFavorites".localize style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavoriteMapPrice:mapPrice];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"addToFavorites".localize style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavoriteMapPrice:mapPrice];
        }];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"close".localize style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
