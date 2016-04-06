//
//  HA_DisWebView.h
//  FrugalTravel
//
//  Created by Andy.He on 16/2/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HA_discountModel.h"

@interface HA_DisWebView : UIViewController

@property (nonatomic ,copy)NSString *urlStr;
@property (nonatomic ,retain)HA_discountModel *disModel;

@end
