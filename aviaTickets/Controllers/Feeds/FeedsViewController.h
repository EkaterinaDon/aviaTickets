//
//  FeedsViewController.h
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "FeedTableViewCell.h"



@interface FeedsViewController : UITableViewController

@property (nonatomic, strong) NSArray *feeds;
- (instancetype)initWithFeeds:(NSArray *)feeds;

@end


