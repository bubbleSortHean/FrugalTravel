//
//  UITabBarController+Night.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "UITabBarController+Night.h"
#import "DKNightVersionManager.h"
#import <objc/runtime.h>

@interface UITabBarController ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DKPicker> *pickers;

@end

@implementation UITabBarController (Night)

- (DKColorPicker)dk_barTintColorPicker {
    return objc_getAssociatedObject(self, @selector(dk_barTintColorPicker));
}

- (void)setDk_barTintColorPicker:(DKColorPicker)picker {
    objc_setAssociatedObject(self, @selector(dk_barTintColorPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.tabBar.barTintColor = picker();
    [self.pickers setValue:[picker copy] forKey:@"setBarTintColor:"];
}

@end
