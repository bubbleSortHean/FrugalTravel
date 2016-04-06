//
//  HA_discountTableViewCell.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/18.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_discountTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "HA_RecModel.h"
#import "HA_discountCollectionCell.h"
#import "Macro.h"
#import "HA_discountViewController.h"
#define CWIDTH self.contentView.frame.size.width
#define CHEIGHT self.contentView.frame.size.height

@interface HA_discountTableViewCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HA_discountTableViewCell

- (void)dealloc{
    [_bigImg release];
    [_discountArr release];
    [_jumpButton release];
    [_collectionView release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [_collectionView reloadData];
    }
    return self;
}



- (void)createView{
    
    self.discountArr = [NSMutableArray array];
    self.bigImg = [[UIImageView alloc] init];
    [self.contentView addSubview:_bigImg];
    [_bigImg release];
    
    UICollectionViewFlowLayout *flowLayout = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowLayout.itemSize = CGSizeMake(SWIDTH / 2 - 10 , 200);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 2;
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 4, 5, 4);
    
    self.collectionView = [[[UICollectionView alloc] initWithFrame:CGRectMake(0, CHEIGHT / 4 , CWIDTH, CHEIGHT * 3 / 4 - 30) collectionViewLayout:flowLayout] autorelease];
    [self.contentView addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[HA_discountCollectionCell class] forCellWithReuseIdentifier:@"reuse"];
    
    self.jumpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _jumpButton.tintColor = [UIColor colorWithRed:0.114 green:0.774 blue:0.213 alpha:1.000];
    [_jumpButton setTitle:@"查看全部特价折扣" forState:UIControlStateNormal];
    _jumpButton.layer.borderWidth = 0.2;
    _jumpButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:_jumpButton];
    [_jumpButton release];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_discountCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuse" forIndexPath:indexPath];
    HA_RecModel *mod = _discountArr[indexPath.row];
    [cell.imgView setImageWithURL:[NSURL URLWithString:mod.photo]];
    // 提取数据里所包含的数字
    NSLog(@"%@",mod.price);
    NSString *newPrice = [[mod.price componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789元起"] invertedSet]] componentsJoinedByString:@""];
    // 富文本改变颜色
    if (_discountArr.count != 0) {
        
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:newPrice];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, newPrice.length - 2)];
    cell.priceLabel.attributedText = attributedString;
    }
    cell.discountLabel.text = mod.priceoff;
    cell.titleLab.text = mod.title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
}


- (void)layoutSubviews{
    [super layoutSubviews];
    _bigImg.frame = CGRectMake(0, 0, CWIDTH, CHEIGHT / 4);
    _collectionView.frame = CGRectMake(0, CHEIGHT / 4 , CWIDTH, CHEIGHT * 3 / 4 - 30);
    _jumpButton.frame = CGRectMake(0, CHEIGHT - 35, SWIDTH, 35);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
