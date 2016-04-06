//
//  HA_roadCollectionCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_roadCollectionCell.h"
#import "Macro.h"

@implementation HA_roadCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createFrame];
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    self.textLab.frame = CGRectMake(0, 0, 120, CHEIGHT / 2);
    self.textLabEN.frame = CGRectMake(0, CHEIGHT / 2, 120, CHEIGHT / 2);
}

- (void)createFrame{
    self.textLab = [[UILabel alloc] init];
    _textLab.font = [UIFont systemFontOfSize:15];
    _textLab.backgroundColor = [UIColor whiteColor];
    _textLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLab];
    
    self.textLabEN = [[UILabel alloc] init];
    _textLabEN.font = [UIFont systemFontOfSize:14];
    _textLabEN.textColor = [UIColor lightGrayColor];
    _textLabEN.backgroundColor = [UIColor whiteColor];
    _textLabEN.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLabEN];
}

@end
