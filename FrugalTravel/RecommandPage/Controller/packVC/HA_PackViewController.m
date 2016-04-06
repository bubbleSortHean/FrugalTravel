//
//  HA_PackViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/23.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_PackViewController.h"
#import "BaseNavigationBar.h"
#import "Macro.h"
#import "HA_packModel.h"
#import "HA_packGroupModel.h"
#import "HA_pickCollectionCell.h"
#import "HA_packDataModel.h"
#import "Objective-Zip.h"

@interface HA_PackViewController () <UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,retain)UITableView *listTablieView;
@property (nonatomic ,retain)UICollectionView *detailCollectionView;

@property (nonatomic ,retain)NSMutableArray *dataArr;
@property (nonatomic ,retain)NSMutableArray *detailArr;

@property (nonatomic ,retain)NSString *flag;
@end

@implementation HA_PackViewController

- (void)dealloc
{
    [_listTablieView release];
    [_detailCollectionView release];
    [_dataArr release];
    [_detailArr release];
    [_flag release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"看锦囊";
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    [self dataJson];
    [self packTableCreate];
    [self packCollectionCreate];
}


- (void)back:(UIBarButtonItem *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 解析数据
- (void)dataJson{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://open.qyer.com/qyer/guide/category_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88267362556636&lon=121.5393344331024&page=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            HA_packModel *mod = [[HA_packModel alloc] init];
            [mod setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:mod];
            [mod release];
        }
        [_listTablieView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}
#pragma mark 创建tableview
- (void)packTableCreate{
    self.listTablieView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH / 4 , SHEIGHT - 64 - 49) style:UITableViewStylePlain];
    _listTablieView.delegate = self;
    _listTablieView.dataSource = self;
    _listTablieView.rowHeight = 70;
    [_listTablieView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listReuse"];
    [self.view addSubview:_listTablieView];
}
#pragma mark tableview delegate/datasoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listReuse" forIndexPath:indexPath];
    HA_packModel *packMod = self.dataArr[indexPath.row];
    cell.backgroundColor = [UIColor colorWithWhite:0.955 alpha:1.000];
    cell.textLabel.text = packMod.cnname;
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _flag = [NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row] infoID]];
    NSLog(@"%@",_flag);
    [self detailJson];
}
#pragma mark collection 数据
- (void)detailJson{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    NSString *url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/guide/channel_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&id=%@&lat=38.88266431522636&lon=121.5394892708786&page=1",_flag];
    [manage GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.detailArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            HA_packDataModel *mod = [HA_packDataModel packWithDictionary:dic];
            [_detailArr addObject:mod];
        }
        
        
        [_detailCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}
#pragma mark 创建collectionView
- (void)packCollectionCreate{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SWIDTH * 3 / 8 - 15, 300);
    _detailCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(SWIDTH / 4, 0, SWIDTH * 3 / 4, SHEIGHT - 64 - 49) collectionViewLayout:flowLayout];
    _detailCollectionView.delegate = self;
    _detailCollectionView.dataSource = self;
    _detailCollectionView.backgroundColor = [UIColor whiteColor];
    [_detailCollectionView registerClass:[HA_pickCollectionCell class] forCellWithReuseIdentifier:@"pickReuse"];
    [self.view addSubview:_detailCollectionView];
}
#pragma mark collectionView delegate / datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([_flag isEqualToString:@"999999"]) {
        return [[self.detailArr lastObject] guides].count;
    }
    return self.detailArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_pickCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pickReuse" forIndexPath:indexPath];
    if ([_flag isEqualToString:@"999999"]) {
        HA_packGroupModel *packMod = [[self.detailArr lastObject] guides][indexPath.row];
        cell.labelCityCN.text = packMod.guide_cnname;
    }else{
        HA_packDataModel *packMod = self.detailArr[indexPath.row];
        cell.labelCityCN.text = packMod.name;
    }

    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
