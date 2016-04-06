//
//  HA_disColViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_disColViewController.h"
#import "DataBaseHandle.h"
#import "Macro.h"
#import "HA_discountModel.h"
#import "HA_DisWebView.h"

@interface HA_disColViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)UITableView *discountColTable;
@property (nonatomic ,retain)NSMutableArray *dataArr;
@property (nonatomic ,retain)UIImageView *noDataImage;

@end

@implementation HA_disColViewController

- (void)dealloc
{
    [super dealloc];
    [_discountColTable release];
    [_dataArr release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArr = [NSMutableArray array];
    self.discountColTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT) style:UITableViewStylePlain];
    _discountColTable.delegate = self;
    _discountColTable.dataSource = self;
    [_discountColTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"disColReu"];
    [self.view addSubview:_discountColTable];
    
    self.noDataImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT)];
    self.noDataImage.image = [UIImage imageNamed:@"noData"];
    [self.view addSubview:_noDataImage];
//    [self judgeArrIsNull];
    _noDataImage.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"disColReu" forIndexPath:indexPath];
    HA_discountModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
#pragma mark webview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HA_DisWebView *web = [[HA_DisWebView alloc] init];
    HA_discountModel *model = self.dataArr[indexPath.row];
    web.disModel = model;
    web.urlStr = model.url;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)judgeArrIsNull{
    if (self.dataArr.count == 0) {
        [self.discountColTable setHidden:YES];
        self.noDataImage.hidden = NO;
    }else{
        [self.discountColTable setHidden:NO];
        self.noDataImage.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setHidden:NO];
    self.dataArr = [[DataBaseHandle shareDataBase] selectAll];
    [self judgeArrIsNull];
    [_discountColTable reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
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
