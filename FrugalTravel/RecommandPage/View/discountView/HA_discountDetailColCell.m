//
//  HA_discountDetailColCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_discountDetailColCell.h"
#import "Macro.h"
#import "UIKit+AFNetworking.h"

@implementation HA_discountDetailColCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCell];
    }
    return self;
}

- (void)createCell{
    self.mainImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CWIDHT, CHEIGHT / 2)];
    [self.contentView addSubview:_mainImgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT / 2, CWIDHT, CHEIGHT / 5)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.numberOfLines = 2;
    [self.contentView addSubview:_titleLabel];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT * 7 / 10, CWIDHT, 30)];
    _dateLabel.font = [UIFont systemFontOfSize:15];
    _dateLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_dateLabel];
    
    self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT * 7 / 10 + 30, CWIDHT / 3, 30)];
    _discountLabel.font = [UIFont systemFontOfSize:15];
    _discountLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_discountLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CWIDHT / 3 - 10, CHEIGHT * 7 / 10 + 30, CWIDHT * 2 / 3, 30)];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
}

- (void)setDisMod:(HA_discountModel *)disMod{
    if (disMod != _disMod) {
        [_disMod release];
        _disMod = [disMod retain];
    }
    [self.mainImgView setImageWithURL:[NSURL URLWithString:disMod.pic]];
    _titleLabel.text = disMod.title;
    _dateLabel.text = disMod.departureTime;
    _discountLabel.text = disMod.lastminute_des;
    NSString *newStr = [[disMod.price componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789元起再减"] invertedSet]] componentsJoinedByString:@""];;
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:newStr];
    [priceStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, newStr.length)];
    if ([newStr rangeOfString:@"再减"].length != 0) {
        [priceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, newStr.length)];
    }else{
    [priceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(newStr.length - 2, 2)];
    }
    _priceLabel.attributedText = priceStr;
    CGFloat titleHeight = [self sizeToFitLabel:_titleLabel size:CGSizeMake(CWIDHT, MAXFLOAT)].height;
    _titleLabel.frame = CGRectMake(0, CHEIGHT / 2, CWIDHT, titleHeight);
}

- (CGSize)sizeToFitLabel:(UILabel *)label size:(CGSize)size{
    CGSize realSize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return realSize;
}

@end
