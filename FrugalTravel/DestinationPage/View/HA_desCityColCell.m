//
//  HA_desCityColCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/29.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_desCityColCell.h"
#import "Macro.h"

@implementation HA_desCityColCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createFrame];
    }
    return self;
}

- (void)dealloc
{
    [_cityImage release];
    [_cnnameLab release];
    [_ennameLab release];
    [super dealloc];
}

- (void)createFrame{
    self.cityImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CWIDHT, CHEIGHT)];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *view = [[UIVisualEffectView alloc] initWithEffect:effect];
    view.frame = _cityImage.bounds;
    view.alpha = 0.5;
    [self.cityImage addSubview:view];
    [self.contentView addSubview:_cityImage];
    
    self.cnnameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT / 2 - 15, CWIDHT, 20)];
    _cnnameLab.textAlignment = NSTextAlignmentCenter;
    _cnnameLab.textColor = [UIColor whiteColor];
    _cnnameLab.font = [UIFont boldSystemFontOfSize:22];
    [self.contentView addSubview:_cnnameLab];
    
    self.ennameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT / 2 + 5, CWIDHT, 20)];
    _ennameLab.textAlignment = NSTextAlignmentCenter;
    _ennameLab.textColor = [UIColor whiteColor];
    _ennameLab.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_ennameLab];
}

@end
