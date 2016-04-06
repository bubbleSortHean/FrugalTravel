//
//  HA_packDataModel.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/23.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_packDataModel : BaseModel

@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,retain)NSMutableArray *guides;

+ (instancetype)packWithDictionary:(NSDictionary *)dic;
@end
