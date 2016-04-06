//
//  HA_ComIndexViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/3/4.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_ComIndexViewController.h"
#import "AFNetworking.h"
#import "HA_comMod.h"
#import "BaseNavigationBar.h"
#import "HA_typesColCell.h"
#import "HA_comTabCell.h"

@interface HA_ComIndexViewController () <UICollectionViewDataSource ,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)NSMutableArray *typesArr;
@property (nonatomic ,retain)NSMutableArray *dataArr;
@property (nonatomic ,retain)UICollectionView *typesCollection;
@property (nonatomic ,retain)UITableView *detailTable;
@property (nonatomic ,retain)BaseNavigationBar *navi;
@property (nonatomic ,assign)BOOL isSelected;

@end

@implementation HA_ComIndexViewController

- (void)dealloc
{
    [_typesCollection release];
    [_detailTable release];
    [_dataArr release];
    [_typesArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navi = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    self.navi.backgroundColor = [UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    [self.navi setTitleColor:[UIColor whiteColor]];
    [self.navi setFontSize:18];
    [self.view addSubview:_navi];
    
    self.isSelected = YES;
    
    UIButton *popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    popBtn.frame = CGRectMake(10, 20, 40, 40);
    [popBtn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [popBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.navi addSubview:popBtn];
    
    [self dataJson];
    [self createCol];
    [self createTable];
}

- (void)click:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dataJson{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://open.qyer.com/qyer/bbs/forum_thread_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&delcache=1&forum_id=%@&forum_type=new&lat=38.88810848820851&lon=121.5462945589065&oauth_token=13a20d37db5b2e28fcf69cd3d3d78c14&page=1",self.uid];
    NSString *newStr = [urlStr stringByAppendingString:@"&track_app_channel=App%2520Store&track_app_version=6.8.4&track_device_info=iPhone8%2C2&track_deviceid=E20BED50-D5D4-437E-9AD5-01DF14D6E668&track_os=ios%25209.0.2&track_user_id=7369417&v=1"];
    
    [manager GET:newStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.typesArr = [NSMutableArray array];
        self.dataArr = [NSMutableArray array];
        
        [self.navi setTitleText: responseObject[@"data"][@"name"]];
        
        for (NSDictionary *dic in responseObject[@"data"][@"types"]) {
            [self.typesArr addObject:dic];
        }
        for (NSDictionary *dic in responseObject[@"data"][@"entry"]) {
            HA_comMod *mod = [[HA_comMod alloc] init];
            [mod setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:mod];
        }
        
        [self.typesCollection reloadData];
        [self.detailTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (void)createCol{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 5, 40);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.typesCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, 40) collectionViewLayout:flowLayout];
    _typesCollection.scrollEnabled = NO;
    _typesCollection.backgroundColor = [UIColor whiteColor];
    _typesCollection.delegate = self;
    _typesCollection.dataSource = self;
    [_typesCollection registerClass:[HA_typesColCell class] forCellWithReuseIdentifier:@"colReuse"];
    [self.view addSubview:_typesCollection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.typesArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_typesColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colReuse" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        cell.line_view.backgroundColor = [UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    }
    cell.tag = indexPath.item + 4000;
    cell.textLab.text = [self.typesArr[indexPath.row] valueForKey:@"name"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_typesColCell *cell = [self.view viewWithTag:indexPath.item + 4000];

    cell.line_view.backgroundColor = [UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    if (indexPath.item > 0) {
        HA_typesColCell *cellFir = [self.view viewWithTag:4000];
        cellFir.line_view.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
    }

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_typesColCell *cell = [self.view viewWithTag:indexPath.item + 4000];
    cell.line_view.backgroundColor = [UIColor colorWithWhite:0.973 alpha:1.000];
}

- (void)createTable{
    self.detailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SWIDTH, SHEIGHT - 104 - 49) style:UITableViewStylePlain];
    _detailTable.delegate = self;
    _detailTable.dataSource = self;
    _detailTable.rowHeight = 120;
    [self.detailTable registerClass:[HA_comTabCell class] forCellReuseIdentifier:@"tabReuse"];
    [self.view addSubview:_detailTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HA_comTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tabReuse" forIndexPath:indexPath];
    HA_comMod *mod = self.dataArr[indexPath.row];
    cell.mod = mod;
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden: YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
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
