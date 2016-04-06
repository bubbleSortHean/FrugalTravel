//
//  HA_desCollectionCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_desCollectionCell.h"
#import "Macro.h"

@interface HA_desCollectionCell ()

@property (nonatomic ,retain)UIView *countView;

@end

@implementation HA_desCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

- (void)dealloc
{
    [_cityImg release];
    [_cityNameCN release];
    [_cityNameEN release];
    [_numLabelCol release];
    [_typeLabel release];
    [_countView release];
    [super dealloc];
}

- (void)createViews{
    self.cityImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CWIDHT, CHEIGHT)];
    [self.contentView addSubview:_cityImg];
    
    self.cityNameCN = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT - 80, CWIDHT, 40)];
    _cityNameCN.font = [UIFont systemFontOfSize:24];
    _cityNameCN.backgroundColor = [UIColor colorWithWhite:0.221 alpha:0.400];
    _cityNameCN.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_cityNameCN];
    
    self.cityNameEN = [[UILabel alloc] initWithFrame:CGRectMake(0, CHEIGHT - 40, CWIDHT, 30)];
    _cityNameEN.textColor = [UIColor whiteColor];
    _cityNameEN.backgroundColor = [UIColor colorWithWhite:0.221 alpha:0.400];
    [self.contentView addSubview:_cityNameEN];
    
    self.numLabelCol = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _numLabelCol.textColor = [UIColor whiteColor];
    _numLabelCol.textAlignment = NSTextAlignmentCenter;
    _numLabelCol.font = [UIFont systemFontOfSize:28];
    
    self.typeLabel = [[UILabel alloc] init];
    _typeLabel.font = [UIFont systemFontOfSize:25];
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.countView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    _countView.backgroundColor = [UIColor colorWithWhite:0.162 alpha:0.7];
    
    [_countView addSubview:_numLabelCol];
    [_countView addSubview:_typeLabel];
    [self.contentView addSubview:_countView];
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
   
    
}



- (void)setModel:(HA_hotCountryMod *)model
{
    if (_model != model) {
        [_model release];
        _model = [model retain];
        
    }
    _numLabelCol.text = [NSString stringWithFormat:@"%@",model.infoCount];
    _typeLabel.text = model.label;
    if (_numLabelCol.text.length > _typeLabel.text.length) {
        
        CGFloat height = 35;
        CGSize size = CGSizeMake(MAXFLOAT, height);
        CGSize realSize;
        realSize = [_numLabelCol.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_numLabelCol.font} context:nil].size;
        
        _numLabelCol.frame = CGRectMake(0, 0, realSize.width + 5, height);
        _countView.frame = CGRectMake(CWIDHT - realSize.width - 10, 10, realSize.width + 5, 2 * height);
        _typeLabel.frame = CGRectMake(0, realSize.height + 5, realSize.width + 5, height);
        
    } else {
        CGFloat height = 35;
        CGSize size = CGSizeMake(MAXFLOAT, height);
        CGSize realSize;
        realSize = [_typeLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_typeLabel.font} context:nil].size;
        
        _numLabelCol.frame = CGRectMake(0, 0, realSize.width + 5, height);
        _countView.frame = CGRectMake(CWIDHT - realSize.width - 10, 10,realSize.width + 5, 2 * height);
        _typeLabel.frame = CGRectMake(0, realSize.height + 5, realSize.width + 5, height);
    }
    
   
}

@end
