//
//  HA_packGroupModel.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/23.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_packGroupModel : BaseModel

@property (nonatomic ,copy)NSString *guide_cnname;
@property (nonatomic ,copy)NSString *guide_enname;
@property (nonatomic ,copy)NSString *guide_pinyin;
@property (nonatomic ,copy)NSString *category_title;
@property (nonatomic ,copy)NSString *country_name_cn;
@property (nonatomic ,copy)NSString *country_name_en;
@property (nonatomic ,copy)NSString *country_name_py;
@property (nonatomic ,copy)NSString *country_id;

@end
