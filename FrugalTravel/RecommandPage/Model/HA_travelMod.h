//
//  HA_travelMod.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/19.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_travelMod : BaseModel

@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *photo;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *replys;
@property (nonatomic, copy)NSString *likes;
@property (nonatomic, copy)NSNumber *views;
@property (nonatomic, copy)NSString *view_url;

@end
