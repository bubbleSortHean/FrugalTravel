//
//  BaseNavigationBar.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseNavigationBar.h"
#define WIDTH_S [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_S [[UIScreen mainScreen] bounds].size.height

@interface BaseNavigationBar ()

@property (nonatomic ,retain)UILabel *title;

@end

@implementation BaseNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                [view removeFromSuperview];
            }
        }
    }
    [self createTitle];
    return self;
}

- (void)createTitle{
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, WIDTH_S / 2 - 25, 200, 50)];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
}

#pragma mark 设置背景颜色
- (void)setTitleBackgroundColor:(UIColor *)color{
    self.title.backgroundColor = color;
}

#pragma mark 设置标题
- (void)setTitleText:(NSString *)title{
    self.title.text = title;
}
#pragma mark 设置字体颜色
- (void)setTitleColor:(UIColor *)color{
    self.title.textColor = color;
}
#pragma mark 设置字体大小
- (void)setFontSize:(CGFloat)size{
    self.title.font = [UIFont boldSystemFontOfSize:size];
}

- (void)layoutSubviews{
    self.title.frame = CGRectMake(WIDTH_S / 2 - 100, 20, 200, 50);
}

@end
