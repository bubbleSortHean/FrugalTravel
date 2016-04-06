//
//  HA_hotelCollectionCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_hotelCollectionCell.h"
#import "Macro.h"

@implementation HA_hotelCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CWIDHT, CHEIGHT)];
    [self.contentView addSubview:_backImage];
    
    self.nameLab = [[UILabel alloc] initWithFrame:self.backImage.bounds];
    self.nameLab.textColor = [UIColor whiteColor];
    self.nameLab.font = [UIFont boldSystemFontOfSize:20];
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLab];
    
//    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.clearButton setBackgroundColor:[UIColor whiteColor]];
//    self.clearButton.frame = self.backImage.bounds;
//    [self.contentView addSubview:_clearButton];
}


@end
