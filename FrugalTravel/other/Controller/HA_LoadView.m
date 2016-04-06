//
//  HA_LoadView.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/24.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_LoadView.h"

@interface HA_LoadView ()

@end

@implementation HA_LoadView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qyer"]];
    launchView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:launchView];
    
    [UIView animateWithDuration:3 animations:^{
        launchView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [self go];
        
        
    }];
    
    
}

// 点击按钮保存数据并切换根视图控制器
- (void) go{
    // 切换根视图控制器
    self.view.window.rootViewController = _tabbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
