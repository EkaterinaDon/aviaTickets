//
//  PlaceViewController.m
//  aviaTickets
//
//  Created by Ekaterina on 7.03.21.
//

#import "PlaceViewController.h"

#define ReuseIdentifier @"reuseIdentifier"

@interface PlaceViewController () <UISearchResultsUpdating>
@property (nonatomic) PlaceType placeType;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *currentArray;
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation PlaceViewController

- (instancetype)initWithType:(PlaceType)type
{
    self = [super init];
    if (self) {
        self.placeType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

#pragma mark - Configyre UI

- (void)configureView {
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview: self.tableView];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"placeCities".localize, @"placeAirports".localize]];
    [self.segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self changeSource];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchArray = [NSArray new];
    self.navigationItem.searchController = self.searchController;
    
    if (self.placeType == PlaceTypeDeparture) {
        self.title = @"from".localize;
    } else {
        self.title = @"to".localize;
    }
}

#pragma mark - Metods

- (void)changeSource
{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            self.currentArray = [[DataManager sharedInstance] cities];
            break;
        case 1:
            self.currentArray = [[DataManager sharedInstance] airports];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[cd] %@", searchController.searchBar.text];
        self.searchArray = [self.currentArray filteredArrayUsingPredicate: predicate];
        [self.tableView reloadData];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.isActive && [self.searchArray count] >0) {
        return [self.searchArray count];
    }
    return [self.currentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[PlaceCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        City *city = (self.searchController.isActive && [self.searchArray count] > 0) ? [self.searchArray objectAtIndex: indexPath.row] : [self.currentArray objectAtIndex:indexPath.row];
        cell.labelName.text = city.name;
        cell.labelCode.text = city.code;
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
        Airport *airport = (self.searchController.isActive && [self.searchArray count] > 0) ? [self.searchArray objectAtIndex: indexPath.row] : [self.currentArray objectAtIndex:indexPath.row];
        cell.labelName.text = airport.name;
        cell.labelCode.text = airport.code;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataSourceType dataType = ((int)self.segmentedControl.selectedSegmentIndex) + 1;
    if (self.searchController.isActive && [self.searchArray count] > 0) {
        [self.delegate selectPlace:[self.searchArray objectAtIndex:indexPath.row] withType:self.placeType andDataType:dataType];
        self.searchController.active = NO;
    } else {
        [self.delegate selectPlace:[self.currentArray objectAtIndex:indexPath.row] withType:self.placeType andDataType:dataType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
