//
//  HA_otherDesCollectionCell.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/21.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "HA_countryMod.h"

@interface HA_otherDesCollectionCell : BaseCollectionViewCell

@property (nonatomic ,retain)UILabel *cnnameLab;
@property (nonatomic ,retain)UILabel *ennameLab;
@property (nonatomic ,retain)HA_countryMod *mod;

@end
