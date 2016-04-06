//
//  HA_DisWebView.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_DisWebView.h"
#import "Macro.h"
#import "DataBaseHandle.h"
@interface HA_DisWebView ()

@property (nonatomic ,retain)UIWebView *webView;
@property (nonatomic ,assign)SelectStatus isCollect;
@property (nonatomic ,retain)UIButton *rightButton;

@end

@implementation HA_DisWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"折扣详情";
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT)];
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    [_rightButton addTarget:self action:@selector(searchprogram) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    
    self.isCollect = [[DataBaseHandle shareDataBase] selectInTable:_disModel];
    if (self.isCollect == InTable) {
        [_rightButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }else if (self.isCollect == NotInTable){
        [_rightButton setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
    }
    
    [_rightButton release];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];

}

- (void)searchprogram{
    self.isCollect = [[DataBaseHandle shareDataBase] selectInTable:_disModel];
    if (self.isCollect == InTable) {
        [[DataBaseHandle shareDataBase] deleteSql:_disModel];
        [_rightButton setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
    }else if (self.isCollect == NotInTable){
        [[DataBaseHandle shareDataBase] insert:_disModel];
        [_rightButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isCollect = [[DataBaseHandle shareDataBase] selectInTable:_disModel];
    if (self.isCollect == InTable) {
        [_rightButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    }else if (self.isCollect == NotInTable){
        [_rightButton setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
    }
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
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
