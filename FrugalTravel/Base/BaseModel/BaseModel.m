//
//  BaseModel.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.infoID = value;
    }
    if ([key isEqualToString:@"count"]) {
        self.infoCount = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.desp = value;
    }

}

@end
