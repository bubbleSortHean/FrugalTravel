//
//  HA_DesViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_desCollectionCell.h"
#import "HA_DesViewController.h"
#import "HA_countryMod.h"
#import "HA_hotCountryMod.h"
#import "HA_desColReuseView.h"
#import "HA_otherDesCollectionCell.h"
#import "HA_dataMod.h"
#import "HA_secOtherReuseView.h"
#import "HA_DesCityViewController.h"
#import "DKNightVersion.h"

@interface HA_DesViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,retain)UISearchBar *searchBar;
@property (nonatomic ,retain)UICollectionView *desCollection;
@property (nonatomic ,retain)NSMutableArray *hotArr;
@property (nonatomic ,retain)NSMutableArray *countryArr;
@property (nonatomic ,retain)NSMutableArray *dataArr;
@property (nonatomic ,retain)HA_dataMod *mainDataMod;
@property (nonatomic ,retain)UICollectionViewFlowLayout *flowLayout;

@end

@implementation HA_DesViewController

- (void)dealloc
{
    [_searchBar release];
    [_desCollection release];
    [_hotArr release];
    [_countryArr release];
    [_dataArr release];
    [_mainDataMod release];
    [_flowLayout release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // searchBar & navigation & tabBar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SWIDTH - 40, 44)];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH - 40, 44)];
    [_searchBar setBackgroundImage:[[UIImage alloc] init]];
    _searchBar.barTintColor =[UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    [titleView addSubview:_searchBar];
    
    self.navigationItem.titleView = titleView;
    
    // searchBar setting
    // 找到searchbar的searchField属性
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    if (searchField) {
        // 背景色
        [searchField setBackgroundColor:[UIColor colorWithRed:0.074 green:0.649 blue:0.524 alpha:1.000]];
        // 设置字体颜色 / 占位符 (必须)
        searchField.textColor = [UIColor whiteColor];
        searchField.placeholder = @"搜索目的地";
        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        // 圆角
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.masksToBounds = YES;
        
    }
    // searchBar 图标设置
    [_searchBar setImage:[UIImage imageNamed:@"magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    // 透明度
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    [self desCollectionCreate];
    [self createData];
    
    HA_desCollectionCell *cellDes = [self.view viewWithTag:10010];
    cellDes.model = _mainDataMod.hot_country[0];
    
    HA_otherDesCollectionCell *cellOth = [self.view viewWithTag:10020];
    cellOth.mod = _mainDataMod.country[0];
}
#pragma mark 解析数据
- (void)createData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotArr = [NSMutableArray array];
        self.countryArr = [NSMutableArray array];
        self.dataArr = [NSMutableArray array];
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            HA_dataMod *dataMod = [HA_dataMod destinModelWithDictionary:dic];
            [self.dataArr addObject:dataMod];
            
        }
        _mainDataMod = self.dataArr[0];
        [_desCollection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}
#pragma mark destination collectionView
- (void)desCollectionCreate{
    
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 2 - 10, SHEIGHT / 3 + 20);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.desCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT - 49 -64) collectionViewLayout:flowLayout];
    _desCollection.delegate = self;
    _desCollection.dataSource = self;
    _desCollection.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    // regist cell
    [_desCollection registerClass:[HA_desCollectionCell class] forCellWithReuseIdentifier:@"descell"];
    [_desCollection registerClass:[HA_otherDesCollectionCell class] forCellWithReuseIdentifier:@"othercell"];
    [self.view addSubview:_desCollection];
    // header
    [_desCollection registerClass:[HA_desColReuseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerReuse"];
    [_desCollection registerClass:[HA_secOtherReuseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sectionTwo"];
    
    
}

#pragma mark collectionView 代理 / 头视图
#pragma mark block 在这
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        HA_desColReuseView *mapView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerReuse" forIndexPath:indexPath];
        mapView.passBlock = ^(NSString *str){
            for (HA_dataMod *mod in _dataArr) {
                if ([mod.cnname isEqualToString:str]) {
                    _mainDataMod = mod;
                }
            }
            [_desCollection reloadData];
        };
        return mapView;
        
    } else {
        
        HA_secOtherReuseView *hotView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"sectionTwo" forIndexPath:indexPath];
        if (_mainDataMod.cnname != NULL) {
            hotView.otherLabel.text = [NSString stringWithFormat:@"%@其它目的地", _mainDataMod.cnname ];
            hotView.otherLabel.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
            hotView.sortLabel.text = @"拼音首字母排序";
        }
        if ([_mainDataMod.cnname isEqualToString:@"南极洲"]) {
            hotView.hidden = YES;
        } else{
            hotView.hidden = NO;
        }
        return hotView;
        
    }
    
}
#pragma mark 头视图尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(SWIDTH, 250);
    } else {
        
        return CGSizeMake(SWIDTH, 50);
    }
}

#pragma mark 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

#pragma mark required
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _mainDataMod.hot_country.count;
    }else{
        return _mainDataMod.country.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HA_desCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"descell" forIndexPath:indexPath];
        cell.tag = 10010;
        if(_mainDataMod.hot_country.count != 0){
            HA_hotCountryMod *hotMod = _mainDataMod.hot_country[indexPath.row];
            cell.model = hotMod;
            cell.cityNameCN.text = hotMod.cnname;
            cell.cityNameEN.text = hotMod.enname;
            
            [cell.cityImg setImageWithURL:[NSURL URLWithString:hotMod.photo] placeholderImage:[UIImage imageNamed:@"backFind"]];
            
        }
        return cell;
    } else {
        HA_otherDesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"othercell" forIndexPath:indexPath];
        cell.tag = 10020;
        if (_mainDataMod.country.count != 0) {
            
            HA_countryMod *countryMod = _mainDataMod.country[indexPath.row];
            cell.mod = countryMod;
        }
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HA_hotCountryMod *hot = _mainDataMod.hot_country[indexPath.row];
        HA_DesCityViewController *desVC = [[HA_DesCityViewController alloc] init];
        desVC.cityID = hot.infoID;
        desVC.cityFlag = hot.flag;
        [self.navigationController pushViewController:desVC animated:YES];
        NSLog(@"%@",hot.infoID);
    }else{
        HA_countryMod *country = _mainDataMod.country[indexPath.row];
        NSLog(@"%@",country.infoID);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return CGSizeMake(SWIDTH - 5, 44);
    } else{
        return CGSizeMake(SWIDTH / 2 - 10, SHEIGHT / 3 + 20);
    }
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
