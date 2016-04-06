//
//  HA_disPoiModel.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/26.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_disPoiModel : BaseModel

@property (nonatomic ,copy)NSString *continent_id;
@property (nonatomic ,copy)NSString *continent_name;
@property (nonatomic ,retain)NSMutableArray *country;

+ (instancetype)poiWithDictionary:(NSDictionary *)dic;

@end
