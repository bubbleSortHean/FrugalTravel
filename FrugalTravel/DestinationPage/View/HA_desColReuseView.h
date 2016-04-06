//
//  HA_desColReuseView.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@interface HA_desColReuseView : BaseCollectionReusableView

@property(nonatomic ,retain)UIImageView *imageView;
@property(nonatomic ,retain)UILabel *textLab;
@property(nonatomic ,assign)BOOL isSelect;
@property(nonatomic ,copy)void (^passBlock)(NSString *);


@end
