//
//  HA_discountModel.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_discountModel : BaseModel

@property (nonatomic ,copy)NSString *productType;
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,copy)NSString *pic;
@property (nonatomic ,copy)NSString *price;
@property (nonatomic ,copy)NSString *booktype;
@property (nonatomic ,copy)NSString *firstpay_end_time;
@property (nonatomic ,copy)NSString *end_date;
@property (nonatomic ,copy)NSString *feature;
@property (nonatomic ,copy)NSString *list_price;
@property (nonatomic ,copy)NSString *buy_price;
@property (nonatomic ,retain)NSNumber *self_use;
@property (nonatomic ,retain)NSNumber *first_pub;
@property (nonatomic ,retain)NSNumber *perperty_today_new;
@property (nonatomic ,copy)NSString *sale_count;
@property (nonatomic ,copy)NSString *lastminute_des;
@property (nonatomic ,copy)NSString *url;
@property (nonatomic ,copy)NSString *departureTime;

@end
