//
//  HA_desCityTableCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/29.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_desCityTableCell.h"
#import "HA_desCityColCell.h"
#import "HA_cityViewMod.h"
#import "UIKit+AFNetworking.h"
#import "Macro.h"

@interface HA_desCityTableCell () <UICollectionViewDataSource ,UICollectionViewDelegate>

@property (nonatomic ,retain)UICollectionViewFlowLayout *flowLayout;

@end

@implementation HA_desCityTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCity];
    }
    return self;
}

- (void)dealloc
{
    [_cityArr release];
    [_cityCol release];
    [super dealloc];
}

- (void)createCity{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 10);
    _flowLayout.minimumInteritemSpacing = 5;
    _flowLayout.minimumInteritemSpacing = 5;
    self.cityCol = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, 300) collectionViewLayout:_flowLayout];
    _cityCol.delegate = self;
    _cityCol.dataSource = self;
    _cityCol.backgroundColor = [UIColor whiteColor];
    [_cityCol registerClass:[HA_desCityColCell class] forCellWithReuseIdentifier:@"colCell"];
    [self.contentView addSubview:_cityCol];
}

- (void)layoutSubviews{
    _flowLayout.itemSize = CGSizeMake(SWIDTH / 2 - 15, 135);
    _cityCol.frame = CGRectMake(0, 0, SWIDTH, 300);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cityArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_desCityColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colCell" forIndexPath:indexPath];
    HA_cityViewMod *cityMod = self.cityArr[indexPath.row];
    [cell.cityImage setImageWithURL:[NSURL URLWithString:cityMod.photo]];
    cell.cnnameLab.text = cityMod.cnname;
    cell.ennameLab.text = cityMod.enname;
    return cell;
}

@end
