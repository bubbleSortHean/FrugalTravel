//
//  BaseCollectionViewCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "DKNightVersion.h"

@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor darkGrayColor]);
    }
    return self;
}

@end
