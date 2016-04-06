//
//  HA_headerCollectionCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/18.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_headerCollectionCell.h"

@implementation HA_headerCollectionCell

- (void)dealloc
{
    [_imageView release];
    [_label release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView{
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    _imageView.backgroundColor = [UIColor whiteColor];
    _imageView.layer.cornerRadius = ( self.contentView.frame.size.height - 50 ) / 2;
    _imageView.layer.masksToBounds = YES;
    
    _label = [[UILabel alloc] init];
    [self.contentView addSubview:_label];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:15];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.contentView.frame.size.width - 20, self.contentView.frame.size.height - 50);
    _label.frame = CGRectMake(-10, self.contentView.frame.size.height - 50, self.contentView.frame.size.width, 30);
}

@end
