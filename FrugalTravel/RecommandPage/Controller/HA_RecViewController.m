//
//  HA_RecViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_RecViewController.h"
#import "Macro.h"
#import "MJRefresh.h"
#import "HA_RecModel.h"
#import "HA_travelMod.h"
#import "HA_SlideModel.h"
#import "HA_headerCollectionCell.h"
#import "HA_StationTableViewCell.h"
#import "HA_discountTableViewCell.h"
#import "HA_discountCollectionCell.h"
#import "HA_travelTableCell.h"
#import "HA_PackViewController.h"
#import "HA_webViewController.h"
#import "HA_ CarouselPic.h"
#import "HABannerView.h"
#import "HA_discountViewController.h"
#import "HA_hotelViewController.h"
#import "HA_roadViewController.h"
#import "HA_SearchViewController.h"

@interface HA_RecViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
/* 
    searchBar 搜索框
    scrollArr 轮播图数组
    dataArr   数据数组
    mainTable tableview
*/
@property (nonatomic, retain)UISearchBar *searchBar;
@property (nonatomic, retain)UISearchController *searchController;

@property (nonatomic, retain)NSMutableArray *scrollArr;
@property (nonatomic, retain)NSMutableArray *disSubArr;;
@property (nonatomic, retain)NSMutableArray *discountArr;
@property (nonatomic, retain)NSMutableArray *stationData;
@property (nonatomic, retain)NSMutableArray *travelArr;
@property (nonatomic, retain)NSArray *sectionArr;

@property (nonatomic, retain)UITableView *mainTable;
@property (nonatomic, retain)UICollectionView *btnCollection;

@property (nonatomic, retain)UITapGestureRecognizer *tapBig;
@property (nonatomic, retain)UITapGestureRecognizer *tapLeft;
@property (nonatomic, retain)UITapGestureRecognizer *tapRight;

@property (nonatomic, retain)HA__CarouselPic *carousel;
@property (nonatomic, retain)HABannerView *bannerView;

@property (nonatomic, assign)NSInteger index;
@property (nonatomic, copy)void (^block)();

@end

@implementation HA_RecViewController

- (void)dealloc{
    [_searchBar release];
    [_disSubArr release];
    [_discountArr release];
    [_scrollArr release];
    [_mainTable release];
    [_sectionArr release];
    [_btnCollection release];
    [_tapBig release];
    [_tapLeft release];
    [_tapRight release];
    [_carousel release];
    [_bannerView release];
    Block_release(_block);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // navigation SearchBar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SWIDTH - 40 * FIT_SCREEN_WIDTH, 44 * FIT_SCREEN_HEIGHT)];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH - 40 * FIT_SCREEN_WIDTH, 44 * FIT_SCREEN_HEIGHT)];
    titleView.tag = 9001;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.frame = CGRectMake(0, 0, SWIDTH - 40, 44);
    _searchController.searchResultsUpdater = self;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.barTintColor = [UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    [_searchController.searchBar setBackgroundImage:[[UIImage alloc] init]];
    [titleView addSubview:_searchController.searchBar];
    
    self.navigationItem.titleView = titleView;
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.index = 1;
    
    // 利用runtime修改内部背景色
    // 找到searchbar的searchField属性
    UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
    if (searchField) {
        // 背景色
        [searchField setBackgroundColor:[UIColor colorWithRed:0.074 green:0.649 blue:0.524 alpha:1.000]];
        // 设置字体颜色 / 占位符 (必须)
        searchField.textColor = [UIColor whiteColor];
        searchField.placeholder = @"placeholder";
        // 根据私有属性@"_placeholderLabel.textColor" 找到placeholder的字体颜色
        [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        // 圆角
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.masksToBounds = YES;
    }
    // searchBar 图标设置
    [_searchBar setImage:[UIImage imageNamed:@"magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];


    self.sectionArr = @[@"发现下一站",@"抢特价折扣",@"看热门游记"];
    [self dataMedthod];
    [self travelData];
    [self tableCreate];

    self.bannerView = [[HABannerView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 240 * FIT_SCREEN_HEIGHT)];
    _bannerView.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"change" object:nil];
    [_searchBar release];
}

#pragma mark 通知中心修改背景色
- (void)changeColor:(NSNotification *)change{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults boolForKey:@"isOn"]) {
        self.mainTable.backgroundColor = [UIColor darkGrayColor];
    }else{
        self.mainTable.backgroundColor = [UIColor whiteColor];
    }
}
#pragma mark 数据解析
- (void)dataMedthod{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://open.qyer.com/qyer/recommands/entry?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&lat=38.88260101886134&lon=121.5394741744573&page=1&track_app_channel=App%2520Store&track_app_version=6.8.3" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.scrollArr = [NSMutableArray array];
        self.disSubArr = [NSMutableArray array];
        self.stationData = [NSMutableArray array];
        self.discountArr = [NSMutableArray array];
        self.travelArr = [NSMutableArray array];
        // 轮播
        for (NSDictionary *dic in responseObject[@"data"][@"slide"]) {
            HA_SlideModel *model = [[HA_SlideModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.scrollArr addObject:model];
        }
        // 轮播图
        self.bannerView.dataArr = self.scrollArr;
        UIView *head = [self.view viewWithTag:1111];
        [head addSubview:_bannerView];
        
        // 搜索占位字
        _searchController.searchBar.placeholder = responseObject[@"data"][@"search"];
        for (NSDictionary *dic in responseObject[@"data"][@"subject"]) {
            HA_RecModel *model = [[HA_RecModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_stationData addObject:model];
        }
        
        // dis_sub
        for (NSDictionary *dic in responseObject[@"data"][@"discount_subject"]) {
            HA_RecModel *model = [[HA_RecModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_disSubArr addObject:model];
        }
        
        // discount
        for (NSDictionary *dic in responseObject[@"data"][@"discount"]) {
            HA_RecModel *model = [[HA_RecModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_discountArr addObject:model];
        }
        [_mainTable reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}
#pragma mark 下拉刷新数据
- (void)travelData{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];

    NSString *url = @"http://open.qyer.com/qyer/recommands/trip?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&oauth_token=47d29fbcc8bf80cb0a71f2be79da617e&page=1&track_app_channel=App%2520Store&track_app_version=6.8.3&track_device_info=iPhone7%2C2&track_deviceid=B038EC96-77B5-4879-93CD-BD5BEE67AE9A&track_os=ios%25209.2&track_user_id=7325921&type=index&v=1";
    [manage GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.travelArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            HA_travelMod *mod = [[HA_travelMod alloc] init];
            [mod setValuesForKeysWithDictionary:dic];
            [_travelArr addObject:mod];
        }
        _index++;
        [_mainTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

#pragma mark 上拉方法
- (void)travelDataNew{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];

    NSString *URLData = [NSString stringWithFormat:@"http://open.qyer.com/qyer/recommands/trip?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=10&oauth_token=47d29fbcc8bf80cb0a71f2be79da617e&page=%ld",(long)_index];
    NSString *url = @"&track_app_channel=App%2520Store&track_app_version=6.8.3&track_device_info=iPhone7%2C2&track_deviceid=B038EC96-77B5-4879-93CD-BD5BEE67AE9A&track_os=ios%25209.2&track_user_id=7325921&type=index&v=1";
    NSString *data = [NSString stringWithFormat:@"%@%@",URLData,url];
    NSLog(@"%@",data);
    [manage GET:data parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"data"]) {
            HA_travelMod *mod = [[HA_travelMod alloc] init];
            [mod setValuesForKeysWithDictionary:dic];
            [_travelArr addObject:mod];
        }
        _index++;
        [_mainTable reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

#pragma mark 创建tableview
- (void)tableCreate{
    self.mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT - 69 * FIT_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:_mainTable];
    _mainTable.delegate = self;
    _mainTable.dataSource = self;
    // 创建头视图
    _mainTable.rowHeight = SHEIGHT / 2 ;
    _mainTable.tableHeaderView = [self createTableHeader];
    
    // 下拉
    [_mainTable addHeaderWithTarget:self action:@selector(refreshView)];
    _mainTable.headerRefreshingText = @"跑啊,跑啊,跑啊...";
    
    // 上拉
    [_mainTable addFooterWithTarget:self action:@selector(loadDataView)];
    _mainTable.footerRefreshingText = @"来啦,来啦,来啦...";
    [_mainTable release];
    
    
}

#pragma mark 刷新方法
- (void)refreshView{
    [self dataMedthod];
    [self travelData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_mainTable reloadData];
        [_btnCollection reloadData];
        [_mainTable headerEndRefreshing];
        [_btnCollection headerEndRefreshing];
    });
}

#pragma mark 加载方法
- (void)loadDataView{
    [self travelDataNew];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_mainTable reloadData];
        [_mainTable footerEndRefreshing];
    });
}
#pragma mark 头视图
- (UIView *)createTableHeader{
    UIView *header = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT - 400  * FIT_SCREEN_HEIGHT)] autorelease];
    header.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    header.tag = 1111;


    
    // collectionViewForHeader
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 4 - 30, header.frame.size.height - 230 * FIT_SCREEN_HEIGHT);
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 30, 10, 10);
    
    self.btnCollection = [[[UICollectionView alloc] initWithFrame:CGRectMake(0, 240 * FIT_SCREEN_HEIGHT, SWIDTH, header.frame.size.height - 240 * FIT_SCREEN_HEIGHT) collectionViewLayout:flowLayout] autorelease];
    _btnCollection.backgroundColor = [UIColor colorWithWhite:0.816 alpha:0.8];
    _btnCollection.scrollEnabled = NO;
    _btnCollection.delegate = self;
    _btnCollection.dataSource = self;
    [_btnCollection registerClass:[HA_headerCollectionCell class] forCellWithReuseIdentifier:@"btnCollection"];
    [header addSubview:_btnCollection];
    return header;
}
#pragma mark 头视图collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *name = @[@"看锦囊",@"抢折扣",@"订酒店",@"旅途中"];
    NSMutableArray *picArr = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"p%ld",(long)i]];
        [picArr addObject:image];
    }
    HA_headerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"btnCollection" forIndexPath:indexPath];
    cell.label.text = name[indexPath.row];
    cell.imageView.image = picArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HA_PackViewController *packVC = [[HA_PackViewController alloc] init];
        [self.navigationController pushViewController:packVC animated:YES];
    } else if (indexPath.row == 1){
        HA_discountViewController *disVC = [[HA_discountViewController alloc] init];
        [self.navigationController pushViewController:disVC animated:YES];
    } else if (indexPath.row == 2){
        HA_hotelViewController *hotelVC = [[HA_hotelViewController alloc] init];
        [self.navigationController pushViewController:hotelVC animated:YES];
    } else{
        HA_roadViewController *roadVC = [[HA_roadViewController alloc] init];
//        [self.navigationController pushViewController:roadVC animated:YES];
        [self presentViewController:roadVC animated:YES completion:nil];
    }
}

#pragma mark tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _travelArr.count;
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HA_webViewController *web = [[HA_webViewController alloc] init];
    if (indexPath.section == 2) {
        HA_travelMod *mod = self.travelArr[indexPath.row];
        web.titleStr = mod.title;
        NSString *urlStr = [NSString stringWithFormat:@"http://appview.qyer.com/bbs/thread-%@-1.html?source=app&client_id=qyer_ios&track_user_id=7369417&track_deviceid=E20BED50-D5D4-437E-9AD5-01DF14D6E668&track_app_version=6.8.3",mod.infoID];
        NSLog(@"%@",urlStr);
        web.urlStr = urlStr;
        [self.navigationController pushViewController:web animated:YES];
    }else{
        UIAlertController *act = [UIAlertController alertControllerWithTitle:@"提示" message:@"待实现" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"未实现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [act addAction:action];
        [self.navigationController presentViewController:act animated:YES completion:nil];
    }
}

#pragma mark section 标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"abc";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[[UIView alloc] init] autorelease];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, SWIDTH, 20 * FIT_SCREEN_HEIGHT)];
        label.text = _sectionArr[section];
        label.font = [UIFont systemFontOfSize:17];
        view.backgroundColor = [UIColor colorWithRed:0.983 green:1.000 blue:0.999 alpha:0.9];
        label.textColor = [UIColor colorWithWhite:0.576 alpha:1.000];
        [view addSubview:label];
        [label release];
        return view;
    }else{
        UIView *view = [[[UIView alloc] init] autorelease];
        UILabel *labelLeft = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, SWIDTH, 20 * FIT_SCREEN_HEIGHT)];
        view.backgroundColor = [UIColor colorWithRed:0.983 green:1.000 blue:0.999 alpha:0.9];
        labelLeft.textColor = [UIColor colorWithWhite:0.576 alpha:1.000];
        labelLeft.font = [UIFont systemFontOfSize:18];
        labelLeft.text = _sectionArr[section];
        [view addSubview:labelLeft];
        [labelLeft release];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 140 * FIT_SCREEN_HEIGHT;
    } else if (indexPath.section == 1){
        return SHEIGHT - 150 * FIT_SCREEN_HEIGHT;
    }else{
        return 350 * FIT_SCREEN_HEIGHT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *station = @"stationReu";
        HA_StationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:station];
        if (!cell) {
            cell = [[HA_StationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:station];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.tapBig = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [cell.bigImage setImageWithURL:[NSURL URLWithString:[_stationData[0] photo]]];
        [cell.bigImage addGestureRecognizer:_tapBig];
        
        self.tapLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [cell.leftImage setImageWithURL:[NSURL URLWithString:[_stationData[1] photo]]];
        [cell.leftImage addGestureRecognizer:_tapLeft];
        
        self.tapRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [cell.rightImage setImageWithURL:[NSURL URLWithString:[_stationData[2] photo]]];
        [cell.rightImage addGestureRecognizer:_tapRight];
        return cell;
    }else if(indexPath.section == 1){
        static NSString *discount = @"discountReu";
        HA_discountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:discount];
        if (!cell) {
            cell = [[HA_discountTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:discount];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        HA_RecModel *subMod = _disSubArr[indexPath.row];
        [cell.bigImg setImageWithURL:[NSURL URLWithString:subMod.photo]];
        [cell.jumpButton addTarget:self action:@selector(clickTojump:) forControlEvents:UIControlEventTouchUpInside];
        cell.discountArr = _discountArr;
        return cell;
    }else{
        static NSString *travel = @"travel";
        HA_travelTableCell *cell = [tableView dequeueReusableCellWithIdentifier:travel];
        if (!cell) {
            cell = [[HA_travelTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:travel];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        HA_travelMod *mod = self.travelArr[indexPath.row];
        [cell.photoImg setImageWithURL:[NSURL URLWithString:mod.photo]];
        cell.titleLable.text = mod.title;
        cell.viewLabel.text = [NSString stringWithFormat:@"%@",mod.views];
        cell.replyLabel.text = mod.replys;
        cell.userLabel.text = mod.username;
        cell.replysImg.image = [UIImage imageNamed:@"reply"];
        cell.viewsImg.image = [UIImage imageNamed:@"view"];
        
        return cell;
    }
}
- (void)clickTojump:(UIButton *)btn{
    HA_discountViewController *disVC = [[HA_discountViewController alloc] init];
    [self.navigationController pushViewController:disVC animated:YES];
}

#pragma mark tableView滑动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchBar resignFirstResponder];
}

#pragma mark section = 0 的点击方法
- (void)tap:(UITapGestureRecognizer *)tap{
    HA_webViewController *webView = [[HA_webViewController alloc] init];
    if (tap == _tapBig) {
        NSLog(@"%@",[_stationData[0] url]);
        webView.urlStr = [_stationData[0] url];
        webView.titleStr = [_stationData[0] title];
    } else if (tap == _tapLeft) {
        NSLog(@"%@",[_stationData[1] photo]);
        webView.urlStr = [_stationData[1] url];
        webView.titleStr = [_stationData[1] title];
    } else {
        NSLog(@"%@",[_stationData[2] photo]);
        webView.urlStr = [_stationData[2] url];
        webView.titleStr = [_stationData[2] title];
    }
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    if (searchController.active == YES) {
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"未完成" message:@"待实现" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:okAction];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    [[self.view viewWithTag:9001] addSubview:_searchController.searchBar];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
