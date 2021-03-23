//
//  FeedsViewController.m
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import "FeedsViewController.h"

#define FeedCellReuseIdentifier @"FeedCellIdentifier"

@interface FeedsViewController ()

@end

@implementation FeedsViewController

- (instancetype)initWithFeeds:(NSArray *)feeds {
    self = [super init];
    if (self) {
        _feeds = feeds;
        self.title = @" Новости";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[FeedTableViewCell class] forCellReuseIdentifier:FeedCellReuseIdentifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return _feeds.count;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FeedCellReuseIdentifier forIndexPath:indexPath];
        cell.feed = [_feeds objectAtIndex:indexPath.row];
        return cell;
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 140.0;
    }
    
    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        FeedViewController *feedViewController = [[FeedViewController alloc] initWithFeed: [_feeds objectAtIndex:indexPath.row]];        
        [self.navigationController showViewController:feedViewController sender:self];
    }

@end
