//
//  HA_roadTableHotCell.h
//  FrugalTravel
//
//  Created by Andy.He on 16/1/28.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HA_roadTableHotCell : BaseTableViewCell

@property (nonatomic ,retain)UICollectionView *hotCollection;
@property (nonatomic ,retain)NSMutableArray *tempArr;

@end
