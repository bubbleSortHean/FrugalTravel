//
//  HA_comGroupCell.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "HA_groupMod.h"
#import "HA_countsMod.h"

@interface HA_comGroupCell : BaseCollectionViewCell

@property (nonatomic ,retain)UILabel *titleLab;
@property (nonatomic ,retain)UILabel *detailLab;
@property (nonatomic ,retain)UIImageView *photoImg;
@property (nonatomic ,retain)HA_groupMod *mod;
@property (nonatomic ,retain)HA_countsMod *countsMod;
@property (nonatomic ,retain)HA_countsMod *companyMod;


@end
