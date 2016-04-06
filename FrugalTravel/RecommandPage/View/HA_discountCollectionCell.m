//
//  HA_discountCollectionCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/18.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_discountCollectionCell.h"
#import "Macro.h"
#define CWIDTH self.frame.size.width


@implementation HA_discountCollectionCell  

- (void)dealloc{
    [_discountLabel release];
    [_titleLab release];
    [_priceLabel release];
    [_imgView release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
        
    }
    return self;
}

- (void)createView{

    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, SWIDTH / 2 - 10, CHEIGHT * 2 / 3 - 10)];
    _imgView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_imgView];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT * 2 / 3 - 5, SWIDTH / 2 - 10, 40)];
    _titleLab.font = [UIFont systemFontOfSize:15];
    _titleLab.numberOfLines = 2;
    [self.contentView addSubview:_titleLab];
    
    self.discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT * 2 / 3 + 35, CWIDTH / 2, 30)];
    _discountLabel.font = [UIFont systemFontOfSize:13];
    _discountLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_discountLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CWIDTH / 2 , CHEIGHT * 2 / 3 + 35, CWIDTH / 2, 30)];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor grayColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
}



@end
