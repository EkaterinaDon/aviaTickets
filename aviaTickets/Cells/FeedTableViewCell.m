//
//  FeedTableViewCell.m
//  aviaTickets
//
//  Created by Ekaterina on 10.03.21.
//

#import "FeedTableViewCell.h"

@implementation FeedTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        self.contentView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        self.contentView.layer.shadowRadius = 10.0;
        self.contentView.layer.shadowOpacity = 1.0;
        self.contentView.layer.cornerRadius = 6.0;
        self.contentView.backgroundColor = [UIColor whiteColor];
                
        _labelTitle = [[UILabel alloc] initWithFrame:self.bounds];
        _labelTitle.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
        _labelTitle.numberOfLines = 0;
        [self.contentView addSubview:_labelTitle];
                
        _labelPublished = [[UILabel alloc] initWithFrame:self.bounds];
        _labelPublished.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightLight];
        _labelPublished.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_labelPublished];
                
        _labelContent = [[UILabel alloc] initWithFrame:self.bounds];
        _labelContent.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
        [self.contentView addSubview:_labelContent];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = CGRectMake(10.0, 10.0, [UIScreen mainScreen].bounds.size.width - 20.0, self.frame.size.height - 20.0);
    _labelTitle.frame = CGRectMake(16.0, 10.0, self.contentView.frame.size.width - 32.0, 40.0);
    _labelPublished.frame = CGRectMake(16.0, CGRectGetMaxY(_labelTitle.frame) + 10.0, self.contentView.frame.size.width - 32.0, 20.0);
    _labelContent.frame = CGRectMake(16.0, CGRectGetMaxY(_labelPublished.frame) + 10.0, self.contentView.frame.size.width - 32.0, 40.0);
}


- (void)setFeed:(Feed *)feed {
    _feed = feed;
    _labelTitle.text = [NSString stringWithFormat: @"%@", feed.title];
    _labelPublished.text = [NSString stringWithFormat: @"%@", feed.publishedAt];    
    _labelContent.text = [NSString stringWithFormat: @"%@", feed.descript];
   
}

@end
