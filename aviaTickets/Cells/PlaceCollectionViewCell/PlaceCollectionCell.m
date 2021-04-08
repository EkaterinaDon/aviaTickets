//
//  PlaceCollectionCell.m
//  aviaTickets
//
//  Created by Ekaterina on 16.03.21.
//

#import "PlaceCollectionCell.h"

@implementation PlaceCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.contentView.layer.shadowColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        self.contentView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        self.contentView.layer.shadowRadius = 10.0;
        self.contentView.layer.shadowOpacity = 1.0;
        self.contentView.layer.cornerRadius = 6.0;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.labelName = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 80, 40)];
        self.labelName.textAlignment = NSTextAlignmentLeft;
        self.labelName.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
        self.labelName.numberOfLines = 0;
        [self.contentView addSubview:self.labelName];
        
        
        self.labelCode = [[UILabel alloc] initWithFrame: CGRectMake(5, 50, 80, 40)];
        self.labelCode.textAlignment = NSTextAlignmentLeft;
        self.labelCode.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightLight];
        [self.contentView addSubview:self.labelCode];
    }
    
    return self;
}

@end
