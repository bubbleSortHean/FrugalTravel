//
//  HA_discountTableViewCell.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/18.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HA_discountTableViewCell : UITableViewCell

@property (nonatomic, retain)UIImageView *bigImg;
@property (nonatomic, retain)NSMutableArray *discountArr;
@property (nonatomic ,retain)UIButton *jumpButton;
@property (nonatomic ,retain)UICollectionView *collectionView;
@property (nonatomic ,copy)void (^passClick)();

@end
