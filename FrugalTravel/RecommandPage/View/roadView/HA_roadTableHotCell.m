//
//  HA_roadTableHotCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/28.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_roadTableHotCell.h"
#import "Macro.h"
#import "HA_roadModel.h"
#import "HA_roadCollectionCell.h"

@interface HA_roadTableHotCell () <UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic ,retain)UICollectionViewFlowLayout *flowLayout;

@end

@implementation HA_roadTableHotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCol];
        [self.hotCollection reloadData];
    }
    return self;
}

- (void)createCol{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.hotCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, CHEIGHT) collectionViewLayout:_flowLayout];
    _hotCollection.delegate = self;
    _hotCollection.dataSource = self;
    _hotCollection.scrollEnabled = NO;
    _hotCollection.backgroundColor = [UIColor colorWithWhite:0.967 alpha:1.000];
    [_hotCollection registerClass:[HA_roadCollectionCell class] forCellWithReuseIdentifier:@"hotColCell"];
    [self.contentView addSubview:_hotCollection];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.tempArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_roadCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hotColCell" forIndexPath:indexPath];
    cell.textLab.text = [_tempArr[indexPath.row] cnname];
    cell.textLabEN.text = [_tempArr[indexPath.row] enname];
    return cell;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    _flowLayout.itemSize = CGSizeMake(SWIDTH / 4, 50);
    _flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 0, 25 );
    _flowLayout.minimumInteritemSpacing = 10;
    _flowLayout.minimumLineSpacing = 20;
    _hotCollection.frame = CGRectMake(0, 0, SWIDTH, CHEIGHT);
}

@end
