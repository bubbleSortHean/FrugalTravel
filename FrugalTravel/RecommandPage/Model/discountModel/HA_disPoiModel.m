//
//  HA_disPoiModel.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/26.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_disPoiModel.h"
#import "HA_disCountryModel.h"

@implementation HA_disPoiModel

+ (instancetype)poiWithDictionary:(NSDictionary *)dic{
    HA_disPoiModel *poiMod = [[[HA_disPoiModel alloc] init] autorelease];
    poiMod.country = [NSMutableArray array];
    poiMod.continent_id = [dic objectForKey:@"continent_id"];
    poiMod.continent_name = [dic objectForKey:@"continent_name"];
    NSArray *arr = [dic objectForKey:@"country"];
    for (NSDictionary *aDic in arr) {
        HA_disCountryModel *countryMod = [[HA_disCountryModel alloc] init];
        [countryMod setValuesForKeysWithDictionary:aDic];
        [poiMod.country addObject:countryMod];
        [countryMod release];
    }
    return poiMod;
}

@end
