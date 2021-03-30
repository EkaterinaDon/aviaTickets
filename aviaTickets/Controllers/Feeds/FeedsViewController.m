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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[FeedTableViewCell class] forCellReuseIdentifier:FeedCellReuseIdentifier];
    
    self.title = @"Новости";
    
    [[APIManager sharedInstance] feedsWithRequest: @"ru" withCompletion: ^(NSArray *feeds) {
            if (feeds.count > 0) {
                self.feeds = feeds;
                [self.tableView reloadData];
            }
            else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Увы!" message:@"Не получилось найти новости или ошибка реализации" preferredStyle: UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Закрыть" style:(UIAlertActionStyleDefault) handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
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
