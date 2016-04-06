//
//  HABannerView.m
//  HABannarPic
//
//  Created by Andy.He on 16/2/24.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "HABannerView.h"
#import "BannerCell.h"
#import "HA_SlideModel.h"
#import "HA_webViewController.h"

@interface HABannerView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,strong)UICollectionView *collectionView;
@property (nonatomic ,strong)NSTimer *timer;
@property (nonatomic ,strong)UIPageControl *pageControl;

@end

@implementation HABannerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createCollection:frame];
        [self pageControlCreate];
        [self addtimer];
    }
    return self;
}

- (void)createCollection:(CGRect)frame{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:@"bannerRes"];
    [self addSubview:_collectionView];
    
}

- (void)pageControlCreate{
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _collectionView.frame.size.height - 22, SWIDTH / 2, 22)];
    _pageControl.layer.cornerRadius = 10;
    _pageControl.center = CGPointMake(SWIDTH / 2, _collectionView.frame.size.height - 22);
    self.pageControl.backgroundColor = [UIColor colorWithWhite:0.672 alpha:0.500];
    [self addSubview:_pageControl];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannerRes" forIndexPath:indexPath];
    //    BannerModel *model = _listArr[indexPath.row];
    HA_SlideModel *slideModel = [_dataArr objectAtIndex:indexPath.item];
    cell.model = slideModel;
    return cell;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
    _pageControl.numberOfPages = _dataArr.count;
    [_collectionView reloadData];

}

- (void)addtimer{
    self.timer = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(scrollNext) userInfo:nil repeats:YES];
    // 定时器因为RunLoop的原因,当定时器加到scrollview上(或继承其控件)时,当滑动时,定时器会停止.
    // 解决方案:
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}

- (void)removeTimer{
    if (_timer != nil) {
        // 定时器停止
        [_timer invalidate];
        // 定时器置空
        _timer = nil;
    }
}

- (NSIndexPath *)returnIndex{
    NSIndexPath *currentIndex = [[self.collectionView indexPathsForVisibleItems] lastObject];
    currentIndex = [NSIndexPath indexPathForItem:currentIndex.item inSection:1];
    [self.collectionView scrollToItemAtIndexPath:currentIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndex;
}

- (void)scrollNext{
    if (_dataArr.count != 0) {
        // 获取当前显示cell的indexpath
        NSIndexPath *indexPath = [self returnIndex];
        // item 和 section
        NSInteger item = indexPath.item + 1;
        NSInteger section = indexPath.section;
        // 1.
        if (item == _dataArr.count) {
            item = 0;
            section++;
        }
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:item inSection:section];
        _pageControl.currentPage = item;
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self removeTimer];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HA_SlideModel *model = self.dataArr[indexPath.item];
    HA_webViewController *webView = [[HA_webViewController alloc] init];
    webView.urlStr = model.url;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / SWIDTH ) % ( _dataArr.count);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addtimer];
}
@end
