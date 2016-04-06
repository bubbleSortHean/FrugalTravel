//
//  HA_packDataModel.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/23.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_packDataModel.h"
#import "HA_packGroupModel.h"

@implementation HA_packDataModel

+ (instancetype)packWithDictionary:(NSDictionary *)dic{
    HA_packDataModel *dataModel = [[[HA_packDataModel alloc] init] autorelease];
    dataModel.guides = [NSMutableArray array];
    dataModel.name = [dic objectForKey:@"name"];
    NSArray *guidesArr = [dic objectForKey:@"guides"];
    
    for (NSDictionary *aDic  in guidesArr) {
        HA_packGroupModel *packMod = [[HA_packGroupModel alloc] init];
        [packMod setValuesForKeysWithDictionary:aDic];
        [dataModel.guides addObject:packMod];
    }
    
    return dataModel;
}

@end
