//
//  HA_CarouselColCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_CarouselColCell.h"

@implementation HA_CarouselColCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createImage];
    }
    return self;
}

- (void)createImage{
    self.backView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
    [self.contentView addSubview:_backView];
}

@end
