//
//  HA_StationTableViewCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/18.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_StationTableViewCell.h"
#define WIDTH self.contentView.frame.size.width
#define HEIGHT self.contentView.frame.size.height

@implementation HA_StationTableViewCell

- (void)dealloc
{
    [_bigImage release];
    [_leftImage release];
    [_rightImage release];
    [_moreBtn release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    _bigImage = [[UIImageView alloc] init];
    _bigImage.userInteractionEnabled = YES;
    _bigImage.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:_bigImage];
    
    _leftImage = [[UIImageView alloc] init];
    _leftImage.userInteractionEnabled = YES;
    _leftImage.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_leftImage];
    
    _rightImage = [[UIImageView alloc] init];
    _rightImage.userInteractionEnabled = YES;
    _rightImage.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_rightImage];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:17];
//    [_moreBtn setTitle:@"查看更多精彩专题 more" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:[UIColor colorWithRed:0.000 green:0.540 blue:0.000 alpha:1.000] forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _bigImage.frame = CGRectMake(5, 5, WIDTH - 10, HEIGHT / 2 - 10);
    _leftImage.frame = CGRectMake(5, HEIGHT / 2 , WIDTH / 2 - 15, HEIGHT / 2 - 35);
    _rightImage.frame = CGRectMake(WIDTH / 2 - 5, HEIGHT / 2, WIDTH / 2, HEIGHT / 2 - 35);
    _moreBtn.frame = CGRectMake(0, HEIGHT - 40, WIDTH, 40);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
