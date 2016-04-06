//
//  HA_comReuseView.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_comReuseView.h"

@implementation HA_comReuseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self create];
    }
    return self;
}
- (void)dealloc
{
    [_titLab release];
    [super dealloc];
}
- (void)create{
    self.titLab = [[UILabel alloc] init];
    _titLab.font = [UIFont systemFontOfSize:17];
    _titLab.textColor = [UIColor darkGrayColor];
    [self addSubview:_titLab];
    [_titLab release];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titLab.frame = CGRectMake(10, 5, self.frame.size.width, 40);
}

@end
