//
//  HA_RecModel.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_RecModel : BaseModel

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *priceoff;
@property (nonatomic,copy)NSString *price;
@property (nonatomic,copy)NSString *photo;
@property (nonatomic,copy)NSString *search;
@property (nonatomic,copy)NSString *end_date;
@property (nonatomic ,copy)NSString *url;

@end
