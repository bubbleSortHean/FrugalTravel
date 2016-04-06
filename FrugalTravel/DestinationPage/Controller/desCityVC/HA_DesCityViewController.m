//
//  HA_DesCityViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/29.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_DesCityViewController.h"
#import "HA_cityViewMod.h"
#import "HA_desCityTableCell.h"
#import "Macro.h"
#import "DKNightVersion.h"

@interface HA_DesCityViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)NSMutableArray *picArr;
@property (nonatomic ,retain)NSMutableDictionary *dataDic;
@property (nonatomic ,retain)NSMutableArray *hotArr;
@property (nonatomic ,retain)NSMutableArray *discountArr;
@property (nonatomic ,retain)UITableView *cityTable;
@property (nonatomic ,copy)NSString *url;

@end

@implementation HA_DesCityViewController

- (void)dealloc
{
    [_picArr release];
    [_dataDic release];
    [_hotArr release];
    [_discountArr release];
    [_cityTable release];
    [_url release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self cityDataCreate];
    [self createTable];
}

#pragma mark 解析数据
- (void)cityDataCreate{
    if ([self.cityFlag integerValue] == 1) {
        self.url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&country_id=%@",self.cityID];
        
    }else{
        self.url = [NSString stringWithFormat:@"http://open.qyer.com/qyer/footprint/city_detail?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&city_id=%@",self.cityID];
    }
    NSString *url_last = @"&lat=38.87996628999998&lon=121.5413143&oauth_token=13a20d37db5b2e28fcf69cd3d3d78c14&page=1&track_app_channel=App%2520Store&track_app_version=6.8.3&track_device_info=iPhone8%2C2&track_deviceid=E20BED50-D5D4-437E-9AD5-01DF14D6E668&track_os=ios%25209.0.2&track_user_id=7369417&v=1";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",self.url,url_last];
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.picArr = [NSMutableArray array];
        self.dataDic = [NSMutableDictionary dictionary];
        self.hotArr = [NSMutableArray array];
        self.discountArr = [NSMutableArray array];
        
        self.picArr = responseObject[@"data"][@"photos"];
        self.dataDic = responseObject[@"data"];
        
        for (NSDictionary *dic in responseObject[@"data"][@"hot_city"]) {
            HA_cityViewMod *mod = [[HA_cityViewMod alloc] init];
            [mod setValuesForKeysWithDictionary:dic];
            [self.hotArr addObject:mod];
        }
        [_cityTable reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

#pragma mark 创建城市tableview
- (void)createTable{
    self.cityTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT) style:UITableViewStyleGrouped];
    _cityTable.delegate = self;
    _cityTable.dataSource = self;
    _cityTable.rowHeight = 300;
    _cityTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_cityTable registerClass:[HA_desCityTableCell class] forCellReuseIdentifier:@"cityReuse"];
    [self.view addSubview:_cityTable];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HA_desCityTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityReuse" forIndexPath:indexPath];
    if (self.hotArr.count != 0) {
        cell.cityArr = self.hotArr;
        [cell.cityCol reloadData];
        NSLog(@"%ld",self.hotArr.count);
    }

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return 300;
//    }else{
//        return 300;
//    }
//}

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
