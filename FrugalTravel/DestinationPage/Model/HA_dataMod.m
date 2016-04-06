//
//  HA_dataMod.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_dataMod.h"
#import "HA_hotCountryMod.h"
#import "HA_countryMod.h"

@implementation HA_dataMod

+ (instancetype)destinModelWithDictionary:(NSDictionary *)aDic{
    
    HA_dataMod *aDes = [[[HA_dataMod alloc] init] autorelease];
    
    aDes.hot_country = [NSMutableArray array];
    aDes.country = [NSMutableArray array];
    aDes.cnname = [aDic objectForKey:@"cnname"];
    NSArray *hotArr = [aDic objectForKey:@"hot_country"];
    NSArray *countryArr = [aDic objectForKey:@"country"];
    
    for (NSDictionary *dic in hotArr) {
        HA_hotCountryMod *aModel = [[HA_hotCountryMod alloc] init];
        [aModel setValuesForKeysWithDictionary:dic];
        [aDes.hot_country addObject:aModel];
        [aModel release];
    }
    
    for (NSDictionary *dic in countryArr) {
        
        HA_countryMod *bModel = [[HA_countryMod alloc] init];
        [bModel setValuesForKeysWithDictionary:dic];
        [aDes.country addObject:bModel];
        [bModel release];
    }

    return aDes;
}
@end
