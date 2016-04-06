//
//  HA_MineViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/16.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_MineViewController.h"
#import "Macro.h"
#import "BaseNavigationBar.h"
#import "HA_settingViewController.h"
#import "DKNightVersion.h"
#import "HA_disColViewController.h"
@interface HA_MineViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)UITableView *mineTableView;
@property (nonatomic ,retain)NSMutableArray *infoArr;
@property (nonatomic ,retain)NSMutableArray *picArr;

@end

@implementation HA_MineViewController

- (void)dealloc
{
    [_infoArr release];
    [_picArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self mineTableViewCreate];
    self.navigationController.navigationBar.hidden = YES;
    // 自定义navigationBar
    BaseNavigationBar *navigationBar = [[BaseNavigationBar alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    navigationBar.backgroundColor = [UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000];
    navigationBar.tag = 3001;
    // navi night
    navigationBar.alpha = 0;
    navigationBar.dk_backgroundColorPicker = DKColorWithColors([UIColor colorWithRed:0.039 green:0.747 blue:0.603 alpha:1.000], [UIColor darkGrayColor]);
    
    [self.view addSubview:navigationBar];
    // 标题
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SWIDTH, navigationBar.frame.size.height - 20)];
    label.text = @"我的";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [navigationBar addSubview:label];
    
    // 数组
    self.infoArr = [NSMutableArray arrayWithObjects:@"我的行程",@"我的帖子",@"我的锦囊",@"我的问答",@"我的结伴",@"我的讨论组",@"我的折扣",@"我的优惠券", nil];
    self.picArr = [NSMutableArray array];
    
    // 图片数组
    for (NSInteger i = 1; i < 9; i++) {
        NSString *str = [NSString stringWithFormat:@"s%ld",(long)i];
        [self.picArr addObject:str];
    }
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    settingBtn.alpha = 1;
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setTintColor:[UIColor whiteColor]];
    [settingBtn addTarget:self action:@selector(setBtn:) forControlEvents:UIControlEventTouchUpInside];
    settingBtn.frame = CGRectMake(SWIDTH - 50, 20, 50, 40);
    //    [navigationBar addSubview:settingBtn];
    [self.view addSubview:settingBtn];
}

- (void)setBtn:(UIButton *)btn{
    HA_settingViewController *setVC = [[HA_settingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

#pragma mark 我的tabelview 创建
- (void)mineTableViewCreate{
    self.mineTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, -20, SWIDTH, SHEIGHT - 24) style:UITableViewStylePlain] autorelease];
    _mineTableView.delegate = self;
    _mineTableView.dataSource = self;
    _mineTableView.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x313131);
    [self.view addSubview:_mineTableView];
    [_mineTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mineReuse"];
    [self createTableHeader];
}

#pragma mark headerview
- (void)createTableHeader{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT - 190)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    // 上层imageView
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topImage"]];
    imageView.frame = CGRectMake(0, 0, SWIDTH, 240 * FIT_SCREEN_HEIGHT);
    imageView.tag = 3000;
    imageView.userInteractionEnabled = YES;
    [headerView addSubview:imageView];
//    
//    // 头像
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setImage:[UIImage imageNamed:@"header"] forState:UIControlStateNormal];
//    button.frame = CGRectMake(SWIDTH / 2 - 40, 30, 80, 80 * FIT_SCREEN_HEIGHT);
//    [headerView addSubview:button];
    
    // label
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, SWIDTH, 40 * FIT_SCREEN_HEIGHT)];
    alertLabel.text = @"点击登录,体验更多";
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:alertLabel];
    
//    // 关注 / 粉丝
//    UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    attentionBtn.frame = CGRectMake(0, 200 * FIT_SCREEN_HEIGHT, SWIDTH / 2, 40 * FIT_SCREEN_HEIGHT);
//    attentionBtn.backgroundColor = [UIColor colorWithRed:0.945 green:0.904 blue:0.913 alpha:0.400];
//    [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
//    [headerView addSubview:attentionBtn];
//    
//    UIButton *fansBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    fansBtn.frame = CGRectMake(SWIDTH / 2, 200 * FIT_SCREEN_HEIGHT, SWIDTH / 2, 40 * FIT_SCREEN_HEIGHT);
//    [fansBtn setTitle:@"粉丝" forState:UIControlStateNormal];
//    fansBtn.backgroundColor = [UIColor colorWithRed:0.945 green:0.904 blue:0.913 alpha:0.400];;
//    [headerView addSubview:fansBtn];
    
    // map
    UIImageView *mapImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height + 10, SWIDTH, 250 * FIT_SCREEN_HEIGHT)];
    mapImage.image = [UIImage imageNamed:@"map"];
    [headerView addSubview:mapImage];
    
    _mineTableView.tableHeaderView = headerView;
}

#pragma mark 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineReuse" forIndexPath:indexPath];
    cell.textLabel.text = self.infoArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dk_backgroundColorPicker = DKColorWithRGB(0xffffff, 0x414141);
    cell.textLabel.dk_textColorPicker = DKColorWithColors([UIColor blackColor], [UIColor lightGrayColor]);
    cell.imageView.image = [UIImage imageNamed:self.picArr[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 6) {
        HA_disColViewController *disCol = [[HA_disColViewController alloc] init];
        [self.navigationController pushViewController:disCol animated:YES];
    }else{
        UIAlertController *act = [UIAlertController alertControllerWithTitle:@"提示" message:@"待实现" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"未实现" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [act addAction:action];
        [self.navigationController presentViewController:act animated:YES completion:nil];
    }
    
}

#pragma mark 滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIImageView *view = [self.view viewWithTag:3000];
    BaseNavigationBar *navi = [self.view viewWithTag:3001];
    if (scrollView.contentOffset.y <= -20) {
    
        view.alpha = scrollView.contentOffset.y / 30 + 3;
        view.frame = CGRectMake(scrollView.contentOffset.y + 20, scrollView.contentOffset.y + 20, SWIDTH - 2 * scrollView.contentOffset.y - 40, 240 - scrollView.contentOffset.y);
        
        if (view.alpha < 0.6) {
            view.alpha = 0.6;
        }
        
    }else{
        navi.alpha = scrollView.contentOffset.y / 64.0;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    BaseNavigationBar *navi = [self.view viewWithTag:3001];
    if (scrollView.contentOffset.y <= - 20) {
        navi.alpha = 0;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    BaseNavigationBar *navi = [self.view viewWithTag:3001];
    if (scrollView.contentOffset.y <= - 20) {
        navi.alpha = 0;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    BaseNavigationBar *navi = [self.view viewWithTag:3001];
//    navi.alpha = 0;
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
