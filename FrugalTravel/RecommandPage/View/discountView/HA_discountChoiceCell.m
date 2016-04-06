//
//  HA_discountChoiceCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/26.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_discountChoiceCell.h"
#import "Macro.h"

@implementation HA_discountChoiceCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CWIDHT, CHEIGHT)];
    _backView.userInteractionEnabled = YES;
    [self.contentView addSubview:_backView];
    
    self.textLab = [[UILabel alloc] initWithFrame:_backView.bounds];
    _textLab.font = [UIFont systemFontOfSize:14];
    _textLab.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:_textLab];
}

@end
