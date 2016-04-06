//
//  HA_hotelViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_hotelViewController.h"
#import "Macro.h"
#import "HA_hotelCollectionCell.h"
#import "HA_hotelCollectionHead.h"
#import "HA_hotelMod.h"

@interface HA_hotelViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,retain)UICollectionView *hotelCollection;
@property (nonatomic ,retain)NSMutableArray *hotelArr;
@end

@implementation HA_hotelViewController

- (void)dealloc
{
    [_hotelCollection release];
    [_hotelArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hotelData];
    [self hotelCollectionCreate];
}

#pragma mark 数据解析
- (void)hotelData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://open.qyer.com/qyer/hotel/hot_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=9&lat=38.87997652203123&lon=121.5414011699999&oauth_token=13a20d37db5b2e28fcf69cd3d3d78c14&page=1&track_app_channel=App%2520Store&track_app_version=6.8.3&track_device_info=iPhone8%2C2&track_deviceid=E20BED50-D5D4-437E-9AD5-01DF14D6E668&track_os=ios%25209.0.2&track_user_id=7369417&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotelArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            HA_hotelMod *hotelMod = [[HA_hotelMod alloc] init];
            [hotelMod setValuesForKeysWithDictionary:dic];
            [self.hotelArr addObject:hotelMod];
        }
        [_hotelCollection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

#pragma mark 酒店collection

- (void)hotelCollectionCreate{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 3 - 2, SWIDTH / 3 - 20);
//    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 2;
    self.hotelCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT - 64 - 49) collectionViewLayout:flowLayout];
    [_hotelCollection registerClass:[HA_hotelCollectionCell class] forCellWithReuseIdentifier:@"hotelCell"];
    [_hotelCollection registerClass:[HA_hotelCollectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"hotelHead"];
    _hotelCollection.backgroundColor = [UIColor whiteColor];
    _hotelCollection.delegate = self;
    _hotelCollection.scrollEnabled = YES;
    _hotelCollection.dataSource = self;
    [self.view addSubview:_hotelCollection];
    
}

#pragma mark collection 分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark 尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SWIDTH, SHEIGHT - SWIDTH - 30);
}

#pragma mark 头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    HA_hotelCollectionHead *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"hotelHead" forIndexPath:indexPath];
    
    return header;
}

#pragma mark collection必须的方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.hotelArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_hotelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotelCell" forIndexPath:indexPath];
    HA_hotelMod *mod = self.hotelArr[indexPath.row];
    [cell.backImage setImageWithURL:[NSURL URLWithString:mod.photo]];
    cell.nameLab.text = mod.cnname;
    return cell;
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
