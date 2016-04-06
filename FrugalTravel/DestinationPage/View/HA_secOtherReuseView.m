//
//  HA_secOtherReuseView.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_secOtherReuseView.h"

@implementation HA_secOtherReuseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self create];
    }
    return self;
}

- (void)dealloc
{
    [_otherLabel release];
    [_sortLabel release];
    [super dealloc];
}

- (void)create{
    self.otherLabel = [[UILabel alloc] init];

    
    self.sortLabel = [[UILabel alloc] init];
    _sortLabel.textAlignment = NSTextAlignmentRight;
    _sortLabel.textColor = [UIColor lightGrayColor];
    _sortLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_otherLabel];
    [self addSubview:_sortLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _otherLabel.frame = CGRectMake(5, 0, self.frame.size.width / 2 - 10, self.frame.size.height);
    _sortLabel.frame = CGRectMake(self.frame.size.width / 2 - 20, 0, self.frame.size.width / 2 - 5, self.frame.size.height);
    
}

@end
