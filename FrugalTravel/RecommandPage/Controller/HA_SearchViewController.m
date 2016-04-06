//
//  HA_SearchViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/26.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_SearchViewController.h"
#import "Macro.h"

@interface HA_SearchViewController () <UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>

@property (nonatomic ,retain)UITableView *searchTable;
@property (nonatomic ,retain)UISearchController *searchController;

@end

@implementation HA_SearchViewController


- (void)dealloc
{
    [_searchTable release];
    [_searchController release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(SWIDTH - 50, 0, 40, 44);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:backBtn];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.searchBar.frame = CGRectMake(0, 0, SWIDTH - 60, 44);
    _searchController.searchBar.barTintColor = [UIColor whiteColor];
    _searchController.searchBar.backgroundColor = [UIColor whiteColor];
    _searchController.searchBar.backgroundImage = [[UIImage alloc] init];
    _searchController.searchBar.searchBarStyle = UISearchBarStyleProminent;
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = false;
    [_searchController.searchBar sizeToFit];
    
    UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
    if (searchField) {
        // 背景色
        [searchField setBackgroundColor:[UIColor whiteColor]];
        // 设置字体颜色 / 占位符 (必须)
        searchField.placeholder = @"请输入要查询的内容";
        searchField.textColor = [UIColor lightGrayColor];
        // 根据@"_placeholderLabel.textColor" 找到placeholder的字体颜色
        [searchField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        // 圆角
        searchField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        searchField.layer.borderWidth = 0.5;
        searchField.layer.cornerRadius = 14.0f;
        searchField.layer.masksToBounds = YES;
        
    }

    
    self.searchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SWIDTH, SHEIGHT) style:UITableViewStyleGrouped];
    [titleView addSubview:_searchController.searchBar];
    _searchTable.tableHeaderView = _searchController.searchBar;
    _searchTable.delegate = self;
    _searchTable.dataSource = self;
    [_searchTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchRes"];
    [self.view addSubview:_searchTable];
}

- (void)backBtn:(UIButton *)btn{
    NSLog(@"%@",btn);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"--%@",searchController.searchBar.text);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchRes" forIndexPath:indexPath];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _searchController.active = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources th at can be recreated.
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
