//
//  HA_MapSearchViewController.m
//  FrugalTravel
//
//  Created by Andy.He on 16/3/3.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_MapSearchViewController.h"
#import "Macro.h"
#import <AMapSearchKit/AMapSearchKit.h>

@interface HA_MapSearchViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,retain)UITableView *searchListTable;
@property (nonatomic ,retain)AMapPOI *poi;

@end

@implementation HA_MapSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchListTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT - 64 - 49) style:UITableViewStylePlain];
    _searchListTable.delegate = self;
    _searchListTable.dataSource = self;
    _searchListTable.rowHeight = 80;
//    [_searchListTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"searchReuse"];
    [self.view addSubview:_searchListTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchReuse" forIndexPath:indexPath];
    static NSString *reuse = @"detailRe";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    }
    cell.textLabel.text = [self.searchArr[indexPath.row] name];
    cell.detailTextLabel.text  = [self.searchArr[indexPath.row] address];
    NSLog(@"%@",[self.searchArr[indexPath.row] address]);
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
