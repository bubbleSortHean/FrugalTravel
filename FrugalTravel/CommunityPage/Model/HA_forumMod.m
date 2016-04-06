//
//  HA_forumMod.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_forumMod.h"
#import "HA_groupMod.h"

@implementation HA_forumMod

+ (instancetype)comviewWithDictionary:(NSDictionary *)dic{
    HA_forumMod *forum = [[[HA_forumMod alloc] init] autorelease];
    forum.group = [NSMutableArray array];
    forum.name = [dic objectForKey:@"name"];
    NSArray *arr = [dic objectForKey:@"group"];
    for (NSDictionary *aDic in arr) {
        HA_groupMod *groupMod = [[HA_groupMod alloc] init];
        [groupMod setValuesForKeysWithDictionary:aDic];
        [forum.group addObject:groupMod];
        [groupMod release];
    }
    
    return forum;
}

@end
