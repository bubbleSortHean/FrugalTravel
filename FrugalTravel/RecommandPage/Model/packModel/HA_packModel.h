//
//  HA_packModel.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/23.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseModel.h"

@interface HA_packModel : BaseModel
@property (nonatomic ,copy)NSString *cnname;
@property (nonatomic ,copy)NSString *enname;
@property (nonatomic ,copy)NSString *pdf_count;
@property (nonatomic ,copy)NSString *mobile_count;
@property (nonatomic ,copy)NSString *pinyin;

@end
