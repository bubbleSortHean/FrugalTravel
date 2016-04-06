//
//  BaseViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseViewController.h"
#import "DKNightVersion.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // navigation颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorWithColors([UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000], [UIColor darkGrayColor]);
    // backgroundColor
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor darkGrayColor]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.navigationController resignFirstResponder];
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
