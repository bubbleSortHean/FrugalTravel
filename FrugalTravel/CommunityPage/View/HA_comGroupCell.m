//
//  HA_comGroupCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_comGroupCell.h"
#import "Macro.h"
#import "DKNightVersion.h"

@implementation HA_comGroupCell

- (void)dealloc{
    [_photoImg release];
    [_titleLab release];
    [_detailLab release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    self.photoImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, CHEIGHT - 10, CHEIGHT - 10)];
    [self.contentView addSubview:_photoImg];
    _photoImg.layer.cornerRadius = 5;
    _photoImg.layer.masksToBounds = YES;
    [_photoImg release];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(CHEIGHT + 10, 10, CWIDHT - CHEIGHT -30, CHEIGHT / 2 - 10)];
    _titleLab.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
    _titleLab.font = [UIFont systemFontOfSize:16];
    _titleLab.numberOfLines = 0;
    [self.contentView addSubview:_titleLab];
    [_titleLab release];
    
    self.detailLab = [[UILabel alloc] initWithFrame:CGRectMake(CHEIGHT + 10, _titleLab.frame.size.height + 10, CWIDHT - CHEIGHT - 30, CHEIGHT / 2 - 10)];
    _detailLab.font = [UIFont systemFontOfSize:13];
    _detailLab.numberOfLines = 0;
    _detailLab.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_detailLab];
    [_detailLab release];
}

- (void)setMod:(HA_groupMod *)mod{
    if (_mod != mod) {
        [_mod release];
        _mod = [mod retain];
    }
    _titleLab.text = _mod.name;
    _detailLab.text = [NSString stringWithFormat:@"%@个帖子",_mod.total_threads];
    // title label 自适应
    CGSize sizeT = CGSizeMake(CWIDHT - CHEIGHT - 30, MAXFLOAT);
    CGSize realSizeT = [self fitSizeWithLabel:_titleLab size:sizeT];
    // detail label 自适应
    CGSize realSizeD = [self fitSizeWithLabel:_detailLab size:sizeT];
    
    _titleLab.frame = CGRectMake(CHEIGHT + 10, 10, CWIDHT - CHEIGHT - 30, realSizeT.height);
    _detailLab.frame = CGRectMake(CHEIGHT + 10, _titleLab.frame.size.height + 10, CWIDHT - CHEIGHT - 30, realSizeD.height);
}

- (void)setCountsMod:(HA_countsMod *)countsMod{
    if (_countsMod != countsMod) {
        [_countsMod release];
        _countsMod = [countsMod retain];
    }
    _titleLab.text = @"问答";
    _titleLab.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
    _detailLab.text = [NSString stringWithFormat:@"%@个问题得到解决",_countsMod.ask];
    // title label 自适应
    CGSize sizeT = CGSizeMake(CWIDHT - CHEIGHT - 30, MAXFLOAT);
    CGSize realSizeT = [self fitSizeWithLabel:_titleLab size:sizeT];
    // detail label 自适应
    CGSize realSizeD = [self fitSizeWithLabel:_detailLab size:sizeT];
    
    _titleLab.frame = CGRectMake(CHEIGHT + 10, 10, CWIDHT - CHEIGHT - 30, realSizeT.height);
    _detailLab.frame = CGRectMake(CHEIGHT + 10, _titleLab.frame.size.height + 10, CWIDHT - CHEIGHT - 30, realSizeD.height);
}

- (void)setCompanyMod:(HA_countsMod *)companyMod{
    if (_companyMod != companyMod) {
        [_companyMod release];
        _companyMod = [companyMod retain];
    }
    _titleLab.text = @"结伴";
    _titleLab.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
    _detailLab.text = [NSString stringWithFormat:@"%@个网友在此结伴",_companyMod.company];
    
    // title label 自适应
    CGSize sizeT = CGSizeMake(CWIDHT - CHEIGHT - 30, MAXFLOAT);
    CGSize realSizeT = [self fitSizeWithLabel:_titleLab size:sizeT];
    // detail label 自适应
    CGSize realSizeD = [self fitSizeWithLabel:_detailLab size:sizeT];
    
    _titleLab.frame = CGRectMake(CHEIGHT + 10, 10, CWIDHT - CHEIGHT - 30, realSizeT.height);
    _detailLab.frame = CGRectMake(CHEIGHT + 10, _titleLab.frame.size.height + 10, CWIDHT - CHEIGHT - 30, realSizeD.height);
}
// 传一个size (如果适应宽度,给固定高,反之)
// 传label 自适应
- (CGSize)fitSizeWithLabel:(UILabel *)label size:(CGSize)size{
    
    CGSize realSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    
    return realSize;
}


@end
