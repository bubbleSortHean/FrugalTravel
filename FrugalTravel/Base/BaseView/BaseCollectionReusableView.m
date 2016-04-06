//
//  BaseCollectionReusableView.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/20.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionReusableView.h"
#import "DKNightVersion.h"

@implementation BaseCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor darkGrayColor]);
    }
    return self;
}

@end
