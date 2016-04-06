//
//  HA_discountViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_discountViewController.h"
#import "Macro.h"
#import "HA_discountModel.h"
#import "HA_disTypeModel.h"
#import "HA_disDepModel.h"
#import "HA_disPoiModel.h"
#import "HA_disTimeModel.h"
#import "HA_disCountryModel.h"
#import "HA_discountDetailColCell.h"
#import "HA_discountChoiceCell.h"
#import "HA_DisWebView.h"

@interface HA_discountViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)UICollectionView *disCollection;
@property (nonatomic ,retain)UICollectionView *choiceCollection;

@property (nonatomic ,retain)UITableView *chooseTable;
@property (nonatomic ,retain)UITableView *depTable;
@property (nonatomic ,retain)UITableView *poiTable;
@property (nonatomic ,retain)UITableView *timeTable;

@property (nonatomic ,retain)NSMutableArray *dataArr;
@property (nonatomic ,retain)NSMutableArray *typeArr;
@property (nonatomic ,retain)NSMutableArray *depArr;
@property (nonatomic ,retain)NSMutableArray *poiArr;
@property (nonatomic ,retain)NSMutableArray *timeArr;

@property (nonatomic ,retain)NSMutableArray *midArr;

@property (nonatomic ,assign)BOOL choose;

@end

@implementation HA_discountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self titleview];
    [self createDetail];
    [self createChoiceCol];
    [self dataJson];
    [self TBData];
    [self choiceTable];
}
#pragma mark 解析数据
- (void)dataJson{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://open.qyer.com/lastminute/app_lastminute_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&is_show_pay=1&is_show_supplier=1&lat=38.88263808518695&lon=121.5394390542414&max_id=0&oauth_token=13a20d37db5b2e28fcf69cd3d3d78c14&page=1&page_size=20&product_type=0&times=&track_app_channel=App%2520Store&track_app_version=6.8.3&track_device_info=iPhone8%2C2&track_deviceid=E20BED50-D5D4-437E-9AD5-01DF14D6E668&track_os=ios%25209.0.2&track_user_id=7369417&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"][@"lastminutes"]) {
            HA_discountModel *mod = [[HA_discountModel alloc] init];
            [mod setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:mod];
        }
        [_disCollection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (void)TBData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://open.qyer.com/lastminute/get_all_categorys?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&continent_id=0&count=20&country_id=0&departure=&page=1&times=&track_app_channel=App%2520Store&track_app_version=6.8.3&track_device_info=iPhone5%2C3&track_deviceid=762C154B-E437-4606-A034-7CDB5666FA7E&track_os=ios%25207.0.3&type=0&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.typeArr = [NSMutableArray array];
        self.depArr = [NSMutableArray array];
        self.timeArr = [NSMutableArray array];
        self.poiArr = [NSMutableArray array];
        self.midArr = [NSMutableArray array];
        for (NSDictionary *dicType in responseObject[@"data"][@"type"]) {
            HA_disTypeModel *typeMod = [[HA_disTypeModel alloc] init];
            [typeMod setValuesForKeysWithDictionary:dicType];
            [self.typeArr addObject:typeMod];
        }
        for (NSDictionary *dicDep in responseObject[@"data"][@"departure"]) {
            HA_disDepModel *depMod = [[HA_disDepModel alloc] init];
            [depMod setValuesForKeysWithDictionary:dicDep];
            [self.depArr addObject:depMod];
        }
        for (NSDictionary *dicTime in responseObject[@"data"][@"times_drange"]) {
            HA_disTimeModel *timeMod = [[HA_disTimeModel alloc] init];
            [timeMod setValuesForKeysWithDictionary:dicTime];
            [self.timeArr addObject:timeMod];
        }
        for (NSDictionary *dicPoi in responseObject[@"data"][@"poi"]) {
            HA_disPoiModel *poiMod = [HA_disPoiModel poiWithDictionary:dicPoi];
            [self.poiArr addObject:poiMod];
        }
        
        [_chooseTable reloadData];
        [_timeTable reloadData];
        [_poiTable reloadData];
        [_depTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}


#pragma mark tableview
- (void)choiceTable{
    // 折扣类型
    self.chooseTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SWIDTH, SHEIGHT / 2) style:UITableViewStylePlain];
    _chooseTable.delegate = self;
    _chooseTable.dataSource = self;
    [_chooseTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"chooseTB"];
    _chooseTable.hidden = YES;
    [self.view addSubview:_chooseTable];
    // 出发地
    self.depTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SWIDTH, SHEIGHT / 2) style:UITableViewStylePlain];
    _depTable.delegate = self;
    _depTable.dataSource = self;
    [_depTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"depTB"];
    _depTable.hidden = YES;
    [self.view addSubview:_depTable];
    // 目的地
    self.poiTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SWIDTH, SHEIGHT / 2) style:UITableViewStylePlain];
    _poiTable.delegate = self;
    _poiTable.dataSource = self;
    [_poiTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"poiTB"];
    _poiTable.hidden = YES;
    [self.view addSubview:_poiTable];
    // 旅行时间
    self.timeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, SWIDTH, SHEIGHT / 2) style:UITableViewStylePlain];
    _timeTable.delegate = self;
    _timeTable.dataSource = self;
    [_timeTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"timeTB"];
    _timeTable.hidden = YES;
    [self.view addSubview:_timeTable];
    
}

#pragma mark tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.midArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.tag = indexPath.row;
    if (tableView == _chooseTable) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chooseTB" forIndexPath:indexPath];
        cell.tag = 5000 + indexPath.row;
        HA_disTypeModel *typeMod = self.midArr[indexPath.row];
        cell.textLabel.text = typeMod.catename;
        return cell;
    } else if (tableView == _depTable){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"depTB" forIndexPath:indexPath];
        HA_disDepModel *depMod = self.midArr[indexPath.row];
        cell.tag = 6000 + indexPath.row;
        cell.textLabel.text = depMod.city_des;
        return cell;
    } else if (tableView == _poiTable){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"poiTB" forIndexPath:indexPath];
        HA_disPoiModel *poiMod = self.midArr[indexPath.row];
        cell.tag = 7000 + indexPath.row;
        cell.textLabel.text = poiMod.continent_name;
        return cell;
    } else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"timeTB" forIndexPath:indexPath];
        HA_disTimeModel *timeMod = self.midArr[indexPath.row];
        cell.tag = 8000 + indexPath.row;
        cell.textLabel.text = timeMod.desp;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    if (tableView == _chooseTable) {
        UITableViewCell *cell = [self.view viewWithTag:5000 + indexPath.row];
        HA_discountChoiceCell *disCell = [self.view viewWithTag:3000];
        disCell.textLab.text = cell.textLabel.text;
        _chooseTable.hidden = YES;
    }else if (tableView == _depTable){
        UITableViewCell *cell = [self.view viewWithTag:6000 + indexPath.row];
        HA_discountChoiceCell *disCell = [self.view viewWithTag:3001];
        disCell.textLab.text = cell.textLabel.text;
        _depTable.hidden = YES;
    }else if (tableView == _poiTable){
        UITableViewCell *cell = [self.view viewWithTag:7000 + indexPath.row];
        HA_discountChoiceCell *disCell = [self.view viewWithTag:3002];
        disCell.textLab.text = cell.textLabel.text;
        _poiTable.hidden = YES;
    }else{
        UITableViewCell *cell = [self.view viewWithTag:8000 + indexPath.row];
        HA_discountChoiceCell *disCell = [self.view viewWithTag:3003];
        disCell.textLab.text = cell.textLabel.text;
        _timeTable.hidden = YES;
    }
}
#pragma mark navigation titleview
- (void)titleview{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 44)];
    
    self.navigationItem.titleView = titleView;
}
#pragma mark 详细信息collection
- (void)createDetail{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 2 - 20, 250);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.disCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, SWIDTH, SHEIGHT - 50 - 49 -64) collectionViewLayout:flowLayout];
    _disCollection.delegate = self;
    _disCollection.dataSource = self;
    _disCollection.backgroundColor = [UIColor whiteColor];
    [self.disCollection registerClass:[HA_discountDetailColCell class] forCellWithReuseIdentifier:@"detailCell"];
    [self.view addSubview:_disCollection];
}

#pragma mark 分类
- (void)createChoiceCol{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 4, 50);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.choiceCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 50) collectionViewLayout:flowLayout];
    _choiceCollection.delegate = self;
    _choiceCollection.dataSource = self;
    _choiceCollection.backgroundColor = [UIColor lightGrayColor];
    [_choiceCollection registerClass:[HA_discountChoiceCell class] forCellWithReuseIdentifier:@"choiceCell"];
    [self.view addSubview:_choiceCollection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _choiceCollection) {
        return 4;
    }else{
        return self.dataArr.count; 
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _choiceCollection) {
        NSArray *typeArr = [NSArray arrayWithObjects:@"折扣类型",@"出发地",@"目的地",@"旅行时间", nil];
        HA_discountChoiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"choiceCell" forIndexPath:indexPath];
        cell.tag = indexPath.row + 3000;
        cell.backView.image = [UIImage imageNamed:@"list_tab_left"];
        cell.backView.tag = 1111+indexPath.row;
        _choose = YES;
        cell.textLab.text = typeArr[indexPath.row];
        return cell;
    } else {
    HA_discountDetailColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailCell" forIndexPath:indexPath];
    HA_discountModel *disMod = self.dataArr[indexPath.row];
    cell.disMod = disMod;
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = [UIColor colorWithWhite:0.940 alpha:1.000].CGColor;
    return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _choiceCollection) {
//        HA_discountChoiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"choiceCell" forIndexPath:indexPath];
        HA_discountChoiceCell *cell = [self.view viewWithTag:3000 + indexPath.item];
        cell.backView.image = [UIImage imageNamed:@"list_tab_left_selected"];

            if (indexPath.row == 0) {
                _midArr = _typeArr;
                if (_chooseTable.hidden) {
                    _chooseTable.hidden = NO;
                }else{
                    _chooseTable.hidden = YES;
                    cell.backView.image = [UIImage imageNamed:@"list_tab_left"];
                }
                [_chooseTable reloadData];
            }
            if (indexPath.row == 1) {
                _midArr = _depArr;
                if (_depTable.hidden) {
                    _depTable.hidden = NO;
                }else{
                    _depTable.hidden = YES;
                    cell.backView.image = [UIImage imageNamed:@"list_tab_left"];
                }
                [_depTable reloadData];
            }
            if (indexPath.row == 2) {
                _midArr = _poiArr;
                if (_poiTable.hidden) {
                    _poiTable.hidden = NO;
                }else{
                    _poiTable.hidden = YES;
                    cell.backView.image = [UIImage imageNamed:@"list_tab_left"];
                }
                [_poiTable reloadData];
            }
            if (indexPath.row == 3) {
                _midArr = _timeArr;
                if (_timeTable.hidden) {
                    _timeTable.hidden = NO;
                }else{
                    _timeTable.hidden = YES;
                    cell.backView.image = [UIImage imageNamed:@"list_tab_left"];
                }
                [_timeTable reloadData];
            }
        }
    
    if (collectionView == _disCollection) {
        HA_discountModel *disModel = self.dataArr[indexPath.item];
        HA_DisWebView *web = [[HA_DisWebView alloc] init];
        web.urlStr = disModel.url;
        web.disModel = disModel;
        [self.navigationController pushViewController:web animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _choiceCollection) {
        HA_discountChoiceCell *cell = [self.view viewWithTag:3000 + indexPath.row];
        cell.backView.image = [UIImage imageNamed:@"list_tab_left"];
        
        if (indexPath.row == 0) {
            if (!_chooseTable.hidden) {
                _chooseTable.hidden = YES;
            }
        }
        if (indexPath.row == 1) {
            if (!_depTable.hidden) {
                _depTable.hidden = YES;
            }
        }
        if (indexPath.row == 2) {
            if (!_poiTable.hidden) {
                _poiTable.hidden = YES;
            }
        }
        if (indexPath.row == 3) {
            if (!_timeTable.hidden) {
                _timeTable.hidden = YES;
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
