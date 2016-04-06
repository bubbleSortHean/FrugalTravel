//
//  HA_comTabCell.h
//  FrugalTravel
//
//  Created by Andy.He on 16/3/4.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "HA_comMod.h"

@interface HA_comTabCell : BaseTableViewCell

@property (nonatomic ,retain)UILabel *nameLab;
@property (nonatomic ,retain)UIImageView *photoImg;
@property (nonatomic ,retain)UILabel *titleLab;
@property (nonatomic ,retain)UIImageView *logoImg;
@property (nonatomic ,retain)UILabel *comLab;
@property (nonatomic ,retain)HA_comMod *mod;

@end
