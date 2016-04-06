//
//  BaseNavigationBar.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/22.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavigationBar : UINavigationBar

#pragma mark 设置标题背景颜色
- (void)setTitleBackgroundColor:(UIColor *)color;
#pragma mark 设置标题
- (void)setTitleText:(NSString *)title;
#pragma mark 设置标题字体大小
- (void)setFontSize:(CGFloat)size;
#pragma mark 设置标题字体颜色
- (void)setTitleColor:(UIColor *)color;

@end
