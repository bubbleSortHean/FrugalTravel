//
//  HA_roadViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//
#import "HA_roadViewController.h"
#import "HA_roadModel.h"
#import "HA_roadTableCell.h"
#import "HA_roadTableHotCell.h"
#import "pinyin.h"
#import <iflyMSC/iflyMSC.h>

@interface HA_roadViewController () <UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating,IFlySpeechRecognizerDelegate>

@property (nonatomic ,retain)UITableView *roadTable;
@property (nonatomic ,retain)UICollectionView *roadHotCollection;
@property (nonatomic ,copy)NSString *data;
@property (nonatomic ,retain)NSMutableArray *hotArr;
@property (nonatomic ,retain)NSMutableArray *cityArr;
@property (nonatomic ,retain)NSMutableArray *countArr;
@property (nonatomic ,retain)NSMutableArray *mainArr;
@property (nonatomic ,retain)NSMutableArray *searchList;
@property (nonatomic ,retain)NSMutableArray *searchArr;
@property (nonatomic ,retain)UISearchBar *searchBar;
@property (nonatomic, retain)UISearchController *searchController;
@property (nonatomic, retain)IFlySpeechRecognizer *iFlySpeechRecognizer;
@property (nonatomic, assign)BOOL speechIsOn;
@property (nonatomic ,copy)NSString *speechStr;
@end

@implementation HA_roadViewController

- (void)dealloc
{
    [_speechStr release];
    [_roadTable release];
    [_roadHotCollection release];
    [_data release];
    [_hotArr release];
    [_cityArr release];
    [_countArr release];
    [_mainArr release];
    [_searchList release];
    [_searchArr release];
    [_searchBar release];
    [_searchController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cityData];
    [self roadTableCreate];
    [self createSearch];
    [self speechCreate];
//    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, SWIDTH - 50, 40)];
//    _searchBar.placeholder = @"输入城市名称";
//    _searchBar.barTintColor = [UIColor whiteColor];
//    [self.view addSubview:_searchBar];
//    [_searchBar setBackgroundImage:[[UIImage alloc] init]];
//    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
//    if (searchField) {
//        // 背景色
//        [searchField setBackgroundColor:[UIColor colorWithWhite:0.888 alpha:1.000]];
//        // 设置字体颜色 / 占位符 (必须)
//        searchField.textColor = [UIColor grayColor];
//        searchField.placeholder = @"输入城市名称";
//        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
//        [searchField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
//        // 圆角
//        searchField.layer.cornerRadius = 14.0f;
//        searchField.layer.masksToBounds = YES;
//    
//    }
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20, 50 * FIT_SCREEN_WIDTH, 40 * FIT_SCREEN_HEIGHT);
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *speechBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    speechBtn.frame = CGRectMake(SWIDTH - 50, 20, 50 * FIT_SCREEN_WIDTH, 40 * FIT_SCREEN_HEIGHT);
    [speechBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [speechBtn setTitle:@"识别" forState:UIControlStateNormal];
    [speechBtn addTarget:self action:@selector(createSpeech:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:speechBtn];
}

#pragma mark 创建语音听写对象

- (void)speechCreate{
    self.iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    self.iFlySpeechRecognizer.delegate = self;
    //设置听写模式
    [self.iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    [self.iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
}
- (void)createSpeech:(UIButton *)btn{
    if (self.searchController.active == YES) {
        if (!self.speechIsOn) {
            [btn setTitle:@"停止" forState:UIControlStateNormal];
            [self.iFlySpeechRecognizer startListening];
        }else{
            [btn setTitle:@"识别" forState:UIControlStateNormal];
            [self.iFlySpeechRecognizer stopListening];
            NSLog(@"%@",self.speechStr);
            self.searchController.searchBar.text = self.speechStr;
        }
        self.speechIsOn = !self.speechIsOn;
    }else{
        [self alertShow];
    }
}

- (void)alertShow{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先点击搜索框再进行搜索" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertCon addAction:cancelAction];
    [self presentViewController:alertCon animated:YES completion:nil];
}

- (void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    NSArray * temp = [[NSArray alloc]init];
    NSString * str = [[NSString alloc]init];
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
    [result appendFormat:@"%@",key];
    }
    NSLog(@"听写结果：%@",result);
    //---------讯飞语音识别JSON数据解析---------//
    NSError * error;
    NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"data: %@",data);
    NSDictionary * dic_result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSArray * array_ws = [dic_result objectForKey:@"ws"];
    //遍历识别结果的每一个单词
    for (int i=0; i<array_ws.count; i++) {
        temp = [[array_ws objectAtIndex:i] objectForKey:@"cw"];
        NSDictionary * dic_cw = [temp objectAtIndex:0];
        str = [str stringByAppendingString:[dic_cw objectForKey:@"w"]];
    }
    self.speechStr =  [str stringByReplacingOccurrencesOfString:@"。" withString:@""];;
}


- (void)onError:(IFlySpeechError *)errorCode{
//    NSLog(@"%@",errorCode);
}
#pragma mark 创建搜索
- (void)createSearch{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.roadTable.tableHeaderView = self.searchController.searchBar;
}


- (void)backToView:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark 数据解析
- (void)cityData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://open.qyer.com/qyer/hotel/hot_city_list?client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=199&lat=38.8826346404739&lon=121.5394589321623&oauth_token=13a20d37db5b2e28fcf69cd3d3d78c14&page=1&track_app_channel=App%2520Store&track_app_version=6.8.3&track_device_info=iPhone8%2C2&track_deviceid=E20BED50-D5D4-437E-9AD5-01DF14D6E668&track_os=ios%25209.0.2&track_user_id=7369417&v=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotArr = [NSMutableArray array];
        self.cityArr = [NSMutableArray array];
        self.countArr = [NSMutableArray array];
        self.mainArr = [NSMutableArray array];
        self.searchList = [NSMutableArray array];
        self.searchArr = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            HA_roadModel *roadMod = [[HA_roadModel alloc] init];
            [roadMod setValuesForKeysWithDictionary:dic];
            if (roadMod.is_hot == YES) {
                [self.hotArr addObject:roadMod];
            } else {
            [self.cityArr addObject:roadMod];
            }
        }
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            if (dic[@"cnname"]) {
                [self.searchArr addObject:dic[@"cnname"]];
            }
        }
        // 排序方法
        [self sortedArrayWithChineseObject:self.cityArr];
        // 分区首字母
        for (NSInteger i = 0; i < self.cityArr.count - 1; i++) {
            NSString *pinyinFirst = [[[self.cityArr[i] pinyin] substringToIndex:1] uppercaseString];
            NSString *pinyinSecond = [[[self.cityArr[i + 1] pinyin] substringToIndex:1] uppercaseString];
            if ([pinyinFirst compare: pinyinSecond] < 0) {
                NSMutableArray *arr = [NSMutableArray array];
                [self.mainArr addObject:arr];
                [self.countArr addObject:pinyinSecond];
            }
        }
        NSMutableArray *aArr = [NSMutableArray array];
        NSMutableArray *hotArr = [NSMutableArray array];
        [_mainArr insertObject:aArr atIndex:0];
        [_mainArr insertObject:hotArr atIndex:0];
        [_countArr insertObject:@"A" atIndex:0];
        [_countArr insertObject:@"热门" atIndex:0];
        
        [_roadTable reloadData];
        [_roadHotCollection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
}
#pragma mark 冒泡排序将数组按拼音排序
- (void)sortedArrayWithChineseObject:(NSMutableArray *)mArray {
    for(NSInteger i = 0; i < mArray.count - 1; i++) {
        for(NSInteger j = 0; j < mArray.count - i - 1; j++) {
            NSString *pinyinFirst = [[mArray[j] pinyin] substringToIndex:1];
            NSString *pinyinSecond = [[mArray[j + 1] pinyin] substringToIndex:1];
            if(NSOrderedDescending == [pinyinFirst compare:pinyinSecond]) {
                NSString *tempString = mArray[j];
                mArray[j] = mArray[j + 1];
                mArray[j + 1] = tempString;
            }
        }
    }
}
#pragma mark 创建tableview
- (void)roadTableCreate{
    self.roadTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60 * FIT_SCREEN_HEIGHT, SWIDTH, SHEIGHT - 60 * FIT_SCREEN_HEIGHT) style:UITableViewStylePlain];
    _roadTable.delegate = self;
    _roadTable.dataSource = self;
    [_roadTable registerClass:[HA_roadTableCell class] forCellReuseIdentifier:@"roadCell"];
    [_roadTable registerClass:[HA_roadTableHotCell class] forCellReuseIdentifier:@"hotCell"];
    [_roadTable registerClass:[HA_roadTableCell class] forCellReuseIdentifier:@"searchCell"];
    [self.view addSubview:_roadTable];
}
#pragma mark 分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchController.active == NO) {
        if (section > 0) {
            for (HA_roadModel *mod in _cityArr) {
                if ([[mod.pinyin uppercaseString] hasPrefix:_countArr[section]]) {
                    [_mainArr[section] addObject:mod];
                }
            }
            return [_mainArr[section] count];
        }else{
            return 1;
        }
    }else{
        return self.searchList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0 || _searchController.active == YES) {
        return 50;
    }else{
        return 200;
    }
}
#pragma mark 分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_searchController.active == NO) {
        return self.countArr.count;
    }else{
        return 1;
    }
}
#pragma mark 分区名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.searchController.active == NO) {
    return self.countArr[section];
    }else{
        return @"搜索结果";
    }
}
#pragma mark cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_searchController.active == NO){
        if (indexPath.section > 0) {
            HA_roadTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roadCell" forIndexPath:indexPath];
            HA_roadModel *roadMod = _mainArr[indexPath.section][indexPath.row];
            cell.cityCN.text = roadMod.cnname;
            cell.cityEN.text = roadMod.enname;
            return cell;
        }else{
            HA_roadTableHotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotCell" forIndexPath:indexPath];
            cell.tempArr = _hotArr;
            return cell;
        }
    }else{
        HA_roadTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
        cell.cityCN.text = self.searchList[indexPath.row];
        NSRange rangeStr = [self.searchList[indexPath.row] rangeOfString:self.searchController.searchBar.text];
        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:self.searchList[indexPath.row]];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rangeStr];
        [cell.cityCN setAttributedText:AttributedStr];
        cell.cityEN.text = nil;
        return cell;
    }
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList = [NSMutableArray arrayWithArray:[_searchArr filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.roadTable reloadData];
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
