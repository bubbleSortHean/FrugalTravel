//
//  HA_forumMod.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_forumMod : BaseModel

@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,retain)NSMutableArray *group;

+ (instancetype)comviewWithDictionary:(NSDictionary *)dic;

@end
