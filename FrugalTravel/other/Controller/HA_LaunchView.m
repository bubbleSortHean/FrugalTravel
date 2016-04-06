//
//  HA_LaunchView.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/24.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_LaunchView.h"
#import "Macro.h"
#import "HA_LaunchColCell.h"

@interface HA_LaunchView () <UICollectionViewDataSource,UICollectionViewDelegate>

{
    // 判断是否是第一次进入应用
    BOOL flag;
}

@property (nonatomic ,strong)UICollectionView *collection;
@property (nonatomic ,strong)NSMutableArray *picArr;

@end

@implementation HA_LaunchView

- (void)dealloc
{
    [super dealloc];
    [_collection release];
    [_picArr release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    
    if (![userDef boolForKey:@"notFirst"]) {
        [self createCol];
        self.picArr = [NSMutableArray array];
        
        for (NSInteger i = 0; i < 4; i++) {
            NSString *str = [NSString stringWithFormat:@"userGuide%ld",i];
            [self.picArr addObject:str];
        }
    }
    
}

- (void)createCol{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SWIDTH, SHEIGHT);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT) collectionViewLayout:flowLayout];
    _collection.delegate = self;
    _collection.dataSource = self;
    _collection.pagingEnabled = YES;
    [_collection registerClass:[HA_LaunchColCell class] forCellWithReuseIdentifier:@"colRes"];
    [self.view addSubview:_collection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.picArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_LaunchColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colRes" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_picArr[indexPath.row]];
    return cell;
}

// 点击按钮保存数据并切换根视图控制器
- (void) go{
    flag = YES;
    
    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    // 保存用户数据
    [useDef setBool:flag forKey:@"notFirst"];
    [useDef synchronize];
    // 切换根视图控制器
    self.view.window.rootViewController = _tabbar;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat x = scrollView.contentOffset.x;
    NSLog(@"%g",x);
    //lroundf 四舍五入到最接近的整数
    if ((x / SWIDTH) > 3) {
        [_collection removeFromSuperview];
        [self go];
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
