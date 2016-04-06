//
//  HA_otherDesCollectionCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/21.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_otherDesCollectionCell.h"
#import "Macro.h"
#import "DKNightVersion.h"

@implementation HA_otherDesCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self detailCreate];
    }
    return self;
}

- (void)dealloc
{
    [_cnnameLab release];
    [_ennameLab release];
    [_mod release];
    [super dealloc];
}

- (void)detailCreate{
    
    self.cnnameLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SWIDTH - 10, CHEIGHT)];
    _cnnameLab.font = [UIFont systemFontOfSize:16];
    _cnnameLab.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
    
    self.ennameLab = [[UILabel alloc] init];
    _ennameLab.font = [UIFont systemFontOfSize:13];
    _ennameLab.textColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_cnnameLab];
    [self.contentView addSubview:_ennameLab];
    
}

- (void)setMod:(HA_countryMod *)mod{
    if (_mod != mod) {
        [_mod release];
        _mod = [mod retain];
    }
    _cnnameLab.text = mod.cnname;
    _ennameLab.text = mod.enname;
    UIFont *font = _cnnameLab.font;
    CGSize size = CGSizeMake(MAXFLOAT, 40);
    CGSize realSizeCN = [_cnnameLab.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    _cnnameLab.frame = CGRectMake(10 , 0, realSizeCN.width, 40);
    _ennameLab.frame = CGRectMake(realSizeCN.width + 15, 0, SWIDTH - realSizeCN.width - 15, 40);
}




@end
