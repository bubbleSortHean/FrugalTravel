//
//  HA_desCollectionCell.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "HA_hotCountryMod.h"
@interface HA_desCollectionCell : BaseCollectionViewCell

@property (nonatomic ,retain)UIImageView *cityImg;
@property (nonatomic ,retain)UILabel *numLabelCol;
@property (nonatomic ,retain)UILabel *typeLabel;
@property (nonatomic ,retain)UILabel *cityNameCN;
@property (nonatomic ,retain)UILabel *cityNameEN;


@property (nonatomic , retain) HA_hotCountryMod *model;
@end
