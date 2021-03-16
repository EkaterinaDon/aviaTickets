//
//  PlaceCell.m
//  aviaTickets
//
//  Created by Ekaterina on 7.03.21.
//

#import "PlaceCell.h"

@implementation PlaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labelName = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 0.0, ([UIScreen mainScreen].bounds.size.width - 2.0), 44.0)];
        _labelName.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelName];
                
        _labelCode = [[UILabel alloc] initWithFrame: CGRectMake(20, 0.0, ([UIScreen mainScreen].bounds.size.width - 2.0), 44.0)];
        _labelCode.textAlignment = NSTextAlignmentCenter;
        _labelCode.font = [UIFont systemFontOfSize: 16.0 weight:UIFontWeightLight];
        [self.contentView addSubview:_labelCode];
    }    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
