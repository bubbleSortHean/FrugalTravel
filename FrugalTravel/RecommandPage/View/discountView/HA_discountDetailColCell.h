//
//  HA_discountDetailColCell.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "HA_discountModel.h"

@interface HA_discountDetailColCell : BaseCollectionViewCell

@property (nonatomic ,retain)UIImageView *mainImgView;
@property (nonatomic ,retain)UILabel *titleLabel;
@property (nonatomic ,retain)UILabel *discountLabel;
@property (nonatomic ,retain)UILabel *priceLabel;
@property (nonatomic ,retain)UILabel *dateLabel;
@property (nonatomic ,retain)HA_discountModel *disMod;

@end
