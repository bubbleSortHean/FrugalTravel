//
//  HA_hotelCollectionHead.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@interface HA_hotelCollectionHead : BaseCollectionReusableView
// 底部照片
@property (nonatomic ,retain)UIImageView *backView;
// 标题
@property (nonatomic ,retain)UILabel *titleLab;
// 目的地
@property (nonatomic ,retain)UILabel *desLab;
// 目的地按钮
@property (nonatomic ,retain)UIButton *desButton;

// 日期view
@property (nonatomic ,retain)UIView *dateView;
// 入住,离开日期
@property (nonatomic ,retain)UILabel *checkInLabel;
@property (nonatomic ,retain)UILabel *checkOutLabel;
@property (nonatomic ,retain)UILabel *textCheckIn;
@property (nonatomic ,retain)UILabel *textCheckOut;
// 时间
@property (nonatomic ,retain)UILabel *countLab;

// 搜索
@property (nonatomic ,retain)UIButton *searchBtn;
// 标题
@property (nonatomic ,retain)UILabel *hotelLab;

@end
