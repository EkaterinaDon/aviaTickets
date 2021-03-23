//
//  FeedViewController.h
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import <UIKit/UIKit.h>
#import "Feed.h"
#import <YYWebImage/YYWebImage.h>

#define GenerateNSUrl(url) [NSURL URLWithString:[NSString stringWithFormat:@"%@", url]];

@interface FeedViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *labelTitle;

@property (nonatomic, strong) UILabel *labelPublishedAt;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *labelContent;

@property (nonatomic, strong) UILabel *labelAuthor;


@property (nonatomic, strong) Feed *feed;


- (instancetype)initWithFeed:(Feed *)feed;

@end


