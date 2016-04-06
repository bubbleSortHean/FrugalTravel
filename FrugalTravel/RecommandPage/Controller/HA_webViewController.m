//
//  HA_webViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_webViewController.h"
#import "Macro.h"

@interface HA_webViewController ()

@property (nonatomic ,retain)UIWebView *webView;

@end

@implementation HA_webViewController

- (void)dealloc
{
    [_webView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.titleStr;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT - 64)];
    [self.view addSubview:_webView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backFind"]];
    _webView.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
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
