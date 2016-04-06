//
//  HA_LaunchColCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/24.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_LaunchColCell.h"

@implementation HA_LaunchColCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createView];
    }
    return self;
}

- (void)createView{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:_imageView];
}

@end
