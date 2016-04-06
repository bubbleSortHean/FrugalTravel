//
//  HA_roadModel.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_roadModel : BaseModel

@property (nonatomic ,copy)NSString *cnname;
@property (nonatomic ,copy)NSString *enname;
@property (nonatomic ,copy)NSString *photo;
@property (nonatomic ,copy)NSString *pinyin;
@property (nonatomic ,assign)BOOL is_hot;

@end
