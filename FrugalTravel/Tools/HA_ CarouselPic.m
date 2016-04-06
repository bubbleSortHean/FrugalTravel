//
//  HA_ CarouselPic.m
//  FrugalTravel
//
//  Created by Andy.He on 16/1/25.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HA_ CarouselPic.h"
#import "UIKit+AFNetworking.h"
#import "HA_CarouselColCell.h"

@interface HA__CarouselPic () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , retain)UICollectionView *carouselView;
@property (nonatomic , retain)NSMutableArray *dataArr;
@property (nonatomic , retain)UIPageControl *page;

@end

@implementation HA__CarouselPic

- (void)carouselPicWithArray:(NSMutableArray *)array timeInterval:(NSTimeInterval)time{
    UICollectionViewFlowLayout *CFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    CFlowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    CFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.carouselView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:CFlowLayout];
    [self addSubview:_carouselView];
    _carouselView.delegate = self;
    _carouselView.dataSource = self;
    [_carouselView registerClass:[HA_CarouselColCell class] forCellWithReuseIdentifier:@"carousel"];
    _carouselView.pagingEnabled = YES;
    CFlowLayout.minimumLineSpacing= 0;
    CFlowLayout.minimumInteritemSpacing = 0;
    
    self.dataArr = [NSMutableArray array];
    _dataArr = array;
    if (_dataArr.count != 0) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        [timer fire];
    }
    [_carouselView reloadData];
    NSLog(@"%@",_dataArr);
}

- (void)changeImage{
     NSIndexPath *currentIndexPath=[[self.carouselView indexPathsForVisibleItems] lastObject];
    //计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPath.item+1;
    NSInteger nextSection = currentIndexPath.section;
    if (self.dataArr.count != 0) {
        if (nextItem == self.dataArr.count) {
        
            nextItem = 0;
        }
    }
    //通过动画滚动到下一个位置
    
    NSIndexPath *nextIndexPath=[NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self.carouselView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_CarouselColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"carousel" forIndexPath:indexPath];
    [cell.backView setImageWithURL:[NSURL URLWithString:_dataArr[indexPath.row]]];
    
    return cell;
}

@end
