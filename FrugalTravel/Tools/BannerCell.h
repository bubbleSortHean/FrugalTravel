//
//  BannerCell.h
//  HABannarPic
//
//  Created by Andy.He on 16/2/24.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "HA_travelMod.h"
#import "HA_SlideModel.h"

@interface BannerCell : UICollectionViewCell

@property (nonatomic ,retain)UIImageView *bannerImage;
@property (nonatomic ,retain)UILabel *bannerInfo;
@property (nonatomic ,retain)HA_SlideModel *model;

@end
