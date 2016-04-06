//
//  HA_dataMod.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_dataMod : BaseModel

@property (nonatomic, copy)NSString *cnname;
@property (nonatomic, copy)NSString *enname;
@property (nonatomic, retain)NSMutableArray *hot_country;
@property (nonatomic, retain)NSMutableArray *country;

+(instancetype)destinModelWithDictionary:(NSDictionary *)aDic;
@end
