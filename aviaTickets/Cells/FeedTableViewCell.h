//
//  FeedTableViewCell.h
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import <UIKit/UIKit.h>
#import "Feed.h"


@interface FeedTableViewCell : UITableViewCell

@property (nonatomic, strong) Feed *feed;

@property (nonatomic, strong) UILabel *labelTitle;

@property (nonatomic, strong) UILabel *labelPublished;

@property (nonatomic, strong) UILabel *labelContent;

@end


