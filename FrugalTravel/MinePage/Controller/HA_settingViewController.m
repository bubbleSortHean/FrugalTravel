//
//  HA_settingViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/28.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_settingViewController.h"
#import "BaseNavigationBar.h"
#import "SDImageCache.h"
#import "Macro.h"
#import "DKNightVersion.h"
#import "HA_disColViewController.h"
#import <ShareSDKConnector/ShareSDKConnector.h>

@interface HA_settingViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)UITableView *settingTable;
@property (nonatomic ,retain)NSArray *mineSet;
@property (nonatomic ,retain)NSArray *appSet;
@property (nonatomic ,assign)BOOL isOn;

@end

@implementation HA_settingViewController

- (void)dealloc
{
    [_settingTable release];
    [_mineSet release];
    [_appSet release];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"change" object:nil];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BaseNavigationBar *navigationBar = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SWIDTH - 40, 64 * FIT_SCREEN_HEIGHT)];
    navigationBar.backgroundColor = [UIColor whiteColor];
    navigationBar.tag = 4001;
    navigationBar.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    [self.view addSubview:navigationBar];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 20, 40, 40);
    [button setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, SWIDTH - 40, navigationBar.frame.size.height - 20)];
    label.text = @"设置";
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    label.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
    [navigationBar addSubview:label];
    
    self.mineSet = @[@"账号",@"清除缓存",@"夜间模式"];
    self.appSet = @[@"意见反馈",@"评价",@"关于",@"分享"];
    self.isOn = NO;
    [self createTable];
}

- (void)back:(UIButton *)btn{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 设置table
- (void)createTable{
    self.settingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT) style:UITableViewStyleGrouped];
    _settingTable.delegate = self;
    _settingTable.dataSource = self;
    _settingTable.rowHeight = 60;
    self.settingTable.dk_backgroundColorPicker =  DKColorWithRGB(0xffffff, 0x343434);
    self.settingTable.dk_separatorColorPicker = DKColorWithRGB(0xaaaaaa, 0x313131);
    [_settingTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setting"];
    [self.view addSubview:_settingTable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.mineSet.count;
    }else{
        return self.appSet.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    cell.textLabel.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
    if (indexPath.section == 0) {
        cell.textLabel.text = _mineSet[indexPath.row];
    }else{
        cell.textLabel.text = _appSet[indexPath.row];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"个人设置";
    }else{
        return @"应用相关";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NSLog(@"section 0 == %ld ",(long)indexPath.row);
        if (indexPath.row == 1) {
            [self folderSizeWithPath:[self getPath]];
        } else if (indexPath.row == 2) {
            self.isOn =! self.isOn;
            [self dayOrNight];
            ///////
            // 通知中心
            [self nightMode];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:self.isOn forKey:@"isOn"];
            [defaults synchronize];
        }else{
            UIAlertController *act = [UIAlertController alertControllerWithTitle:@"提示" message:@"待实现" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"未实现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [act addAction:action];
            [self.navigationController presentViewController:act animated:YES completion:nil];
        }
    }else{
        if (indexPath.row == 3) {
            [self share];
        }else{
            UIAlertController *act = [UIAlertController alertControllerWithTitle:@"提示" message:@"待实现" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"未实现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [act addAction:action];
            [self.navigationController presentViewController:act animated:YES completion:nil];
        }
    }
}

#pragma mark shareSDK 分享方法
- (void)share{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"topImage"]];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil
         //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

#pragma mark 通知中心夜间模式
- (void)nightMode{
    //发送一个通知
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //创建一个通知，通知的名字是change  ，通知的参数num
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:defaults];
    //注册通知，成为通知的监听者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"change" object:nil];//---------通知中心，设置夜间模式
}

//实现通知的方法
-(void)changeColor:(NSNotification *)note{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isOn = [defaults boolForKey:@"isOn"];
    if (isOn) {//对通知的参数进行判读，如果是1，该怎样......
        NSLog(@"1");
    }else{//对通知的参数进行判读，如果是0，该怎样......
        NSLog(@"0");
    }
}


#pragma mark dknight 夜间模式方法
- (void)dayOrNight{
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) {
        [DKNightVersionManager dawnComing];
    } else {
        [DKNightVersionManager nightFalling];
    }
}
#pragma mark - 第一步，计算缓存文件的大小

//首先获取缓存文件的路径

-(NSString *)getPath{
    //沙盒目录下library文件夹下的cache文件夹
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return path;
}

-(CGFloat)folderSizeWithPath:(NSString *)path{
    //初始化文件管理类
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]){
        //如果存在
        //计算文件的大小
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        for (NSString *fileName in fileArray){
            //获取每个文件的路径
            NSString *filePath = [path stringByAppendingPathComponent:fileName];
            //计算每个子文件的大小
            long fileSize = [fileManager attributesOfItemAtPath:filePath error:nil].fileSize;//字节数
            folderSize += fileSize / 1024.0 / 1024.0;
        }
        //删除缓存文件
        [self deleteFileSize:folderSize];
        return folderSize;
    }
    return 0;
}

#pragma mark - 弹出是否删除的一个提示框，并且告诉用户目前有多少缓存

-(void)deleteFileSize:(CGFloat)folderSize{
    if (folderSize > 0.01){
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小:%.2fM,是否清除？",folderSize] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            // 清理方法
            [self alertAction];
            // 清理成功
            UIAlertController *success = [UIAlertController alertControllerWithTitle:@"提示" message:@"清理成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
            [success addAction:okAction];
            
            [self presentViewController:success animated:YES completion:nil];
            
        }];
        [alertCon addAction:cancelAction];
        [alertCon addAction:okAction];
        [self presentViewController:alertCon animated:YES completion:nil];
    }else{
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"缓存已经全部清理" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [alertCon addAction:okAction];
        [self presentViewController:alertCon animated:YES completion:nil];
    }
}

-(void)alertAction
{
        //彻底删除文件
        [self clearCacheWith:[self getPath]];
}

-(void)clearCacheWith:(NSString *)path{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray * fileArray = [fileManager subpathsAtPath:path];
        for (NSString * fileName in fileArray)
        {
            //可以过滤掉特殊格式的文件
//            if ([fileName hasSuffix:@".png"])
//            {
//                NSLog(@"不删除");
//            }
//            else
//            {
                //获取每个子文件的路径
                NSString * filePath = [path stringByAppendingPathComponent:fileName];
                //移除指定路径下的文件
                [fileManager removeItemAtPath:filePath error:nil];
//            }
        }
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
