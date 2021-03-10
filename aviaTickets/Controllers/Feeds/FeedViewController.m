//
//  FeedViewController.m
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

- (instancetype)initWithFeed:(Feed *)feed {
    self = [super init];
    if (self) {
        _feed = feed;
        self.title = @"Новость";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubviews];
}

- (void) addSubviews {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60)];
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 760);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.scrollEnabled = YES;
    
    
    self.labelTitle = [[UILabel alloc] initWithFrame: CGRectMake(16, 10, [UIScreen mainScreen].bounds.size.width - 32, 200)];
    self.labelTitle.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
    self.labelTitle.numberOfLines = 0;
    self.labelTitle.textAlignment = NSTextAlignmentJustified;
    self.labelTitle.text = self.feed.title;
    [self.scrollView addSubview:self.labelTitle];
    
    self.labelPublishedAt = [[UILabel alloc] initWithFrame:  CGRectMake(16, CGRectGetMaxY(self.labelTitle.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 20)];
    self.labelPublishedAt.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    self.labelPublishedAt.text = self.feed.publishedAt;
    [self.scrollView addSubview:self.labelPublishedAt];
        
    self.imageView = [[UIImageView alloc] initWithFrame: CGRectMake(16, CGRectGetMaxY(self.labelPublishedAt.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 200)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.imageView];
    
    if (self.feed.urlToImage != nil) {
        NSURL *urlLogo = GenerateNSUrl(_feed.urlToImage);
        [self.imageView yy_setImageWithURL:urlLogo options:YYWebImageOptionSetImageWithFadeAnimation];
    }
        
    self.labelContent = [[UILabel alloc] initWithFrame: CGRectMake(16, CGRectGetMaxY(self.imageView.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 300)];
    self.labelContent.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightRegular];
    self.labelContent.numberOfLines = 0;
    self.labelContent.text = self.feed.descript;
    self.labelContent.textAlignment = NSTextAlignmentNatural;
    [self.scrollView addSubview:self.labelContent];
    
        
    self.labelAuthor = [[UILabel alloc] initWithFrame: CGRectMake(16, CGRectGetMaxY(self.labelContent.frame) + 10.0, [UIScreen mainScreen].bounds.size.width - 32, 20)];
    self.labelAuthor.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    self.labelAuthor.textAlignment = NSTextAlignmentRight;
    [self.scrollView addSubview:self.labelAuthor];
    self.labelAuthor.text = [NSString stringWithFormat: @"%@", self.feed.author];
    [self.view addSubview:self.scrollView];    
}

@end
