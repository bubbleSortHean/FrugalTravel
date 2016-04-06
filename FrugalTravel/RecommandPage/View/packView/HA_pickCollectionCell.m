//
//  HA_pickCollectionCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/23.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_pickCollectionCell.h"
#import "Macro.h"

@implementation HA_pickCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.cityImg = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    _cityImg.backgroundColor = [UIColor yellowColor];
    _cityImg.image = [UIImage imageNamed:@"pack"];
    [self.contentView addSubview:_cityImg];
    
    self.labelCityCN = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height * 3 / 4, self.contentView.bounds.size.width, self.contentView.bounds.size.height / 4)];
    self.labelCityCN.backgroundColor = [UIColor colorWithRed:0.653 green:0.667 blue:0.660 alpha:0.6];
    self.labelCityCN.textColor = [UIColor whiteColor];
    self.labelCityCN.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:_labelCityCN];
    
}

@end
