//
//  HA_typesColCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/3/4.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_typesColCell.h"

@implementation HA_typesColCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _textLab.textAlignment = NSTextAlignmentCenter;
        _textLab.font = [UIFont systemFontOfSize:15];
        _textLab.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
        [self.contentView addSubview:_textLab];
        
        self.line_view = [[UIView alloc] initWithFrame:CGRectMake(10, self.contentView.frame.size.height - 3, self.contentView.frame.size.width - 20, 3)];
        self.line_view.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
        [self.contentView addSubview:self.line_view];
    }
    return self;
}

@end
