//
//  HA_roadTableCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_roadTableCell.h"
#import "Macro.h"

@implementation HA_roadTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.cityCN = [[UILabel alloc] init];
    _cityCN.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_cityCN];
    
    self.cityEN = [[UILabel alloc] init];
    _cityEN.font = [UIFont systemFontOfSize:13];
    _cityEN.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_cityEN];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _cityCN.frame = CGRectMake(20, 0, CWIDHT - 20, CHEIGHT * 2 / 3);
    _cityEN.frame = CGRectMake(20, CHEIGHT * 2 / 3, CWIDHT - 20, CHEIGHT / 3);
    
}

@end
