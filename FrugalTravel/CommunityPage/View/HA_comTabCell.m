//
//  HA_comTabCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/3/4.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_comTabCell.h"
#import "UIImageView+WebCache.h"

@implementation HA_comTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self viewCreate];
    }
    return self;
}

- (void)viewCreate{
    self.photoImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_photoImg];
    
    self.titleLab = [[UILabel alloc] init];
    _titleLab.numberOfLines = 2;
    _titleLab.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLab];
    
    self.nameLab = [[UILabel alloc] init];
    _nameLab.font = [UIFont boldSystemFontOfSize:15];
    _nameLab.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:_nameLab];
    
    self.logoImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_logoImg];
    
    self.comLab = [[UILabel alloc] init];
    _comLab.textColor = [UIColor lightGrayColor];
    _comLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_comLab];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.photoImg.frame = CGRectMake(10, 10, 50 * FIT_SCREEN_WIDTH, 50 * FIT_SCREEN_WIDTH);
    _photoImg.layer.cornerRadius = 50 * FIT_SCREEN_WIDTH / 2;
    _photoImg.layer.masksToBounds = YES;
    
    self.titleLab.frame = CGRectMake(60, 20, [UIScreen mainScreen].bounds.size.width - 70 * FIT_SCREEN_WIDTH, self.frame.size.height - 20 * FIT_SCREEN_HEIGHT);
    
    self.nameLab.frame = CGRectMake(20 + 50 * FIT_SCREEN_WIDTH, 15, self.contentView.frame.size.width - 40 + 50 * FIT_SCREEN_WIDTH, 40);
    
    self.logoImg.frame = CGRectMake(self.contentView.frame.size.width - 80, self.contentView.frame.size.height - 22, 16, 16);
    
    self.comLab.frame = CGRectMake(self.contentView.frame.size.width - 60, self.contentView.frame.size.height - 30, 55, 30);
}

- (void)setMod:(HA_comMod *)mod{
    if (_mod != mod) {
        [_mod release];
        _mod = [mod retain];
    }
    _logoImg.image = [UIImage imageNamed:@"reply"];
    _titleLab.text = mod.title;
    _nameLab.text = mod.username;
    [_photoImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar]];
    
    CGSize realSizeT = [self fitSizeWithLabel:_comLab size:CGSizeMake(MAXFLOAT, 30)];
    _comLab.frame = CGRectMake(self.contentView.frame.size.width - 60, self.contentView.frame.size.height - 30, realSizeT.width, 30);
    _comLab.text = mod.replys;
    
}



- (CGSize)fitSizeWithLabel:(UILabel *)label size:(CGSize)size{
    
    CGSize realSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    
    return realSize;
}

@end
