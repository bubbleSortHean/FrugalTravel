//
//  HA_MapViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/30.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "Macro.h"
#import "HA_MapSearchViewController.h"

@interface HA_MapViewController () <MAMapViewDelegate,UITableViewDataSource,UITableViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate>

@property (nonatomic ,retain)MAMapView *mapView;
@property (nonatomic ,retain)UITableView *typeTableView;
@property (nonatomic ,retain)UIButton *trafficBtn;
@property (nonatomic ,retain)UIButton *locateBtn;
@property (nonatomic ,assign)BOOL trafficFlag;
@property (nonatomic ,assign)BOOL locateFlag;
@property (nonatomic ,retain)AMapLocationManager *locationManager;
@property (nonatomic ,retain)AMapSearchAPI *search;
@property (nonatomic ,retain)AMapPOIAroundSearchRequest *request;
@property (nonatomic ,retain)NSMutableArray *searchListArr;
@property (nonatomic ,retain)NSMutableArray *searchLoactionArr;
@property (nonatomic ,retain)NSMutableArray *annoArr;

@end

@implementation HA_MapViewController

- (void)dealloc
{
    [_mapView release];
    [_typeTableView release];
    [_trafficBtn release];
    [_locateBtn release];
    [_locationManager release];
    [_search release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchListArr = [NSMutableArray array];
    self.searchLoactionArr = [NSMutableArray array];
    self.annoArr = [NSMutableArray array];
    
    self.navigationItem.title = @"地图";
    self.navigationController.navigationBar.translucent = NO;
    // 定位
    _mapView.showsUserLocation = YES;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 地图创建
    [self createMap];
    // 类型tableview
    [self createTypeTable];
    // 路况
    [self createBtn];
    // 定位
    [self createLocate];
    // 跳转btn
    [self jump];
}


#pragma mark 大头针 annotation 自定义
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

#pragma mark 跳转btn
- (void)jump{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(20, 50, 40, 40);
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setImage:[UIImage imageNamed:@"comL"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(jumpToSearch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark 创建搜索对象
- (void)createSearch{
    //初始化检索对象
    self.search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
    self.request = [[AMapPOIAroundSearchRequest alloc] init];
//    request.keywords = @"肯德基";
    // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
    // POI的类型共分为20种大类别，分别为：
    // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
    // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
    // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
    _request.types = @"交通设施服务|风景名胜";
    // 排序方式 --- 默认(1)
    _request.sortrule = 0;
    // 半径
    _request.radius = 5000;
    _request.requireExtension = YES;

}

#pragma mark 实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    // 大头针
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    for (AMapPOI *p in response.pois) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        [self.searchLoactionArr addObject:p];
        [self.searchListArr addObject:p];
        
        pointAnnotation.title = p.name;
        pointAnnotation.subtitle = p.address;
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        [_mapView addAnnotation:pointAnnotation];
        [self.annoArr addObject:pointAnnotation];
    }


}

#pragma mark search 跳转
- (void)jumpToSearch:(UIButton *)btn{
    HA_MapSearchViewController *searchView = [[HA_MapSearchViewController alloc] init];
    searchView.searchArr = self.searchListArr;
    [self.navigationController pushViewController:searchView animated:YES];
}

#pragma mark 地图定位button
- (void)createLocate{
    self.locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _locateBtn.frame = CGRectMake(20,SHEIGHT - 200, 40, 50);
    _locateBtn.backgroundColor = [UIColor whiteColor];
    _locateBtn.layer.borderWidth = 0.5;
    _locateBtn.layer.cornerRadius = 5;
    _locateBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_locateBtn addTarget:self action:@selector(locateClick:) forControlEvents:UIControlEventTouchUpInside];
    [_locateBtn setImage:[UIImage imageNamed:@"desL"] forState:UIControlStateNormal];
    _locateFlag = YES;
    [self.view addSubview:_locateBtn];
}

#pragma mark 路况button
- (void)createBtn{
    self.trafficBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _trafficBtn.frame = CGRectMake(350,SHEIGHT - 200, 40, 50);
    _trafficBtn.backgroundColor = [UIColor whiteColor];
    _trafficBtn.layer.borderWidth = 0.5;
    _trafficBtn.layer.cornerRadius = 5;
    _trafficBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_trafficBtn addTarget:self action:@selector(trafficClick:) forControlEvents:UIControlEventTouchUpInside];
    [_trafficBtn setTitle:@"路况" forState:UIControlStateNormal];
    _trafficFlag = YES;
    [self.view addSubview:_trafficBtn];
}

#pragma mark 路况btn 方法
- (void)trafficClick:(UIButton *)btn{
    if (_trafficFlag == YES) {
        _mapView.showTraffic = YES;
    } else{
        _mapView.showTraffic = NO;
    }
    _trafficFlag = !_trafficFlag;
}

#pragma mark 定位btn 方法
- (void)locateClick:(UIButton *)btn{
    if (_locateFlag == NO) {
        _mapView.showsUserLocation = YES;
        // 地图周边搜索
        [self createSearch];
    } else{
        _mapView.showsUserLocation = NO;
        [_mapView removeAnnotations:self.annoArr];
    }
    _locateFlag = !_locateFlag;
}

#pragma mark 创建地图视图
- (void)createMap{
    //配置用户Key
    [AMapLocationServices sharedServices].apiKey =@"771db4162c1e77aa44f53321c507411f";
    [MAMapServices sharedServices].apiKey = @"771db4162c1e77aa44f53321c507411f";
    [AMapSearchServices sharedServices].apiKey = @"771db4162c1e77aa44f53321c507411f";
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT)];
    _mapView.delegate = self;
    // 最小更新距离
    //    _mapView.distanceFilter = 10;
    // 缩放级别
    [_mapView setZoomLevel:15 animated:YES];
    //    [self.mapView setVisibleMapRect:(MAMapRect){220880104, 101476980,15000,15000} animated:YES];
    [_mapView setUserTrackingMode:MAUserTrackingModeFollowWithHeading animated:YES];
    [self.view addSubview:_mapView];
}

#pragma mark 右侧类型tableview
- (void)createTypeTable{
    self.typeTableView = [[UITableView alloc] initWithFrame:CGRectMake(SWIDTH - 75, 50, 70, 88) style:UITableViewStylePlain];
    _typeTableView.delegate = self;
    _typeTableView.dataSource = self;
    _typeTableView.layer.cornerRadius = 10;
    _typeTableView.layer.borderWidth = 0.5;
    //    _typeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _typeTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [_typeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"typeRes"];
    [self.view addSubview:_typeTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"typeRes" forIndexPath:indexPath];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"标准";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"卫星";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        _mapView.mapType = MAMapTypeSatellite;
    }else{
        _mapView.mapType = MAMapTypeStandard;
    }
    
}

#pragma mark 实时定位方法
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        
        // latitude // longitude
        CGFloat latitude = userLocation.coordinate.latitude;
        CGFloat longitude = userLocation.coordinate.longitude;
        CLLocationCoordinate2D centerPoint = CLLocationCoordinate2DMake(latitude, longitude);
        // 地图中心点
        [_mapView setCenterCoordinate:centerPoint animated:YES];
        _request.location = [AMapGeoPoint locationWithLatitude:latitude longitude:longitude];
        //发起周边搜索
        [_search AMapPOIAroundSearch:_request];

    }
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.533 green:0.900 blue:0.846 alpha:0.300];
        pre.strokeColor = [UIColor colorWithRed:0.822 green:0.806 blue:0.900 alpha:1.000];
        pre.lineWidth = 3;
        pre.showsHeadingIndicator = YES;
        pre.lineDashPattern = nil;
        [self.mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
    }
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
