//
//  BannerCell.m
//  HABannarPic
//
//  Created by Andy.He on 16/2/24.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BannerCell.h"
#import "UIImageView+AFNetworking.h"

@implementation BannerCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:_bannerImage];
    
    self.bannerInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 80, self.contentView.frame.size.width, 50)];
    _bannerInfo.textColor = [UIColor whiteColor];
    _bannerInfo.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_bannerInfo];
    
}

- (void)setModel:(HA_SlideModel *)model{
    if (_model != model) {
        _model = model;
    }
    [self.bannerImage setImageWithURL:[NSURL URLWithString:model.photo]];
}
@end
