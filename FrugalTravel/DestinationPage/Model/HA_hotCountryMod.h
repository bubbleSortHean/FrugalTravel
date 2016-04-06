//
//  HA_hotCountryMod.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_hotCountryMod : BaseModel

@property (nonatomic, copy)NSString *cnname;
@property (nonatomic, copy)NSString *enname;
@property (nonatomic, copy)NSString *label;
@property (nonatomic, copy)NSString *photo;
@property (nonatomic, retain)NSNumber *flag;


@end
