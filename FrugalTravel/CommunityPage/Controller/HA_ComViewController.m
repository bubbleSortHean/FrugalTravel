//
//  HA_ComViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_ComViewController.h"
#import "Macro.h"
#import "HA_groupMod.h"
#import "HA_forumMod.h"
#import "HA_countsMod.h"
#import "HA_comGroupCell.h"
#import "HA_comReuseView.h"
#import "DKNightVersion.h"
#import "HA_ComIndexViewController.h"

@interface HA_ComViewController () <UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,retain)UICollectionView *comCollection;
@property (nonatomic ,retain)NSMutableArray *dataArr;
@property (nonatomic ,retain)NSMutableArray *countsArr;
@property (nonatomic ,retain)HA_forumMod *aMod;
@property (nonatomic ,retain)UISearchBar *searchBar;

@end

@implementation HA_ComViewController

- (void)dealloc{
    [_comCollection release];
    [_dataArr release];
    [_countsArr release];
    [_aMod release];
    [_searchBar release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.title = @"社区";
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 0, SWIDTH - 20, 40)];
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
    [self.navigationController.navigationBar addSubview:_searchBar];
    [self createCollection];
    [self dataAnalysis];
}
#pragma mark 解析数据
- (void)dataAnalysis{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    [manage GET:@"http://open.qyer.com/qyer/bbs/entry?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&page=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArr = [NSMutableArray array];
        self.countsArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"][@"forum_list"]) {
            HA_forumMod *forum = [HA_forumMod comviewWithDictionary:dic];
            [_dataArr addObject:forum];
            
        }
        
        NSDictionary *dic = responseObject[@"data"][@"counts"];
        HA_countsMod *mod = [[HA_countsMod alloc] init];
        [mod setValuesForKeysWithDictionary:dic];
        [_countsArr addObject:mod];
        [_comCollection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

- (void)createCollection{
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 2 - 5, 80);
    
    self.comCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH , SHEIGHT - 64 - 49)collectionViewLayout:flowLayout];
    _comCollection.delegate = self;
    _comCollection.dataSource = self;
    _comCollection.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    [self.view addSubview:_comCollection];
    [_comCollection registerClass:[HA_comGroupCell class] forCellWithReuseIdentifier:@"comCell"];
    [_comCollection registerClass:[HA_comReuseView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [_comCollection release];
}

#pragma mark 头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section > 0) {
        HA_comReuseView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        HA_forumMod *mod = _dataArr[indexPath.section - 1];
        view.titLab.text = mod.name;
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor colorWithWhite:0.866 alpha:1.000].CGColor;
        view.layer.dk_borderColorPicker = DKColorWithColors([UIColor colorWithWhite:0.866 alpha:1.000], [UIColor darkGrayColor]);
        view.dk_backgroundColorPicker = DKColorWithColors([UIColor colorWithWhite:0.958 alpha:0.900], [UIColor darkGrayColor]);
        
        return view;
    } else{
        HA_comReuseView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.titLab.text = @"123";
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = [UIColor colorWithWhite:0.866 alpha:1.000].CGColor;
        view.layer.dk_borderColorPicker = DKColorWithColors([UIColor colorWithWhite:0.866 alpha:1.000], [UIColor darkGrayColor]);
        view.dk_backgroundColorPicker = DKColorWithColors([UIColor colorWithWhite:0.958 alpha:0.900], [UIColor darkGrayColor]);
        return view;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        
        HA_forumMod *forum = self.dataArr[section - 1];
        return forum.group.count ;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArr.count + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_comGroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"comCell" forIndexPath:indexPath];
    cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    if (indexPath.section > 0) {
        HA_forumMod *forum = _dataArr[indexPath.section - 1];
        HA_groupMod *group = forum.group[indexPath.row];
        cell.mod = group;
        [cell.photoImg setImageWithURL:[NSURL URLWithString:group.photo]];
    } else {
        if (indexPath.row == 0) {
            HA_countsMod *mod = [_countsArr lastObject];
            cell.photoImg.image = [UIImage imageNamed:@"chart"];
            cell.countsMod = mod;
        }else{
            HA_countsMod *mod = [_countsArr lastObject];
            cell.companyMod = mod;
            cell.photoImg.image = [UIImage imageNamed:@"friends"];
        }
    }
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0) {
        HA_ComIndexViewController *comIndex = [[HA_ComIndexViewController alloc] init];
        HA_forumMod *forum = _dataArr[indexPath.section - 1];
        HA_groupMod *group = forum.group[indexPath.row];
        comIndex.uid = group.infoID;
        [self.navigationController pushViewController:comIndex animated:YES];
    }else{
        UIAlertController *act = [UIAlertController alertControllerWithTitle:@"提示" message:@"待实现" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"未实现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }];
        [act addAction:action];
        [self.navigationController presentViewController:act animated:YES completion:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(0, 0);
    }else{
        return CGSizeMake(SWIDTH , 45);
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.searchBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.searchBar.hidden = NO;
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
