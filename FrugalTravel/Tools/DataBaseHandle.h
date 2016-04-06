//
//  DataBaseHandle.h
//  FrugalTravel
//
//  Created by Andy.He on 16/2/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HA_discountModel.h"
#import <sqlite3.h>

@interface DataBaseHandle : NSObject

{
    sqlite3 *dataBasePoint;
}

typedef NS_ENUM(NSUInteger, SelectStatus) {
    InTable = 1,
    NotInTable = 2,
    SelectError = 3,
};

@property(nonatomic ,copy)NSString *text;

+ (instancetype)shareDataBase;
- (void)openDB;
- (void)createTable;
- (SelectStatus)selectInTable:(HA_discountModel *)dis;
- (void)insert:(HA_discountModel *)dis;
- (void)deleteSql:(HA_discountModel *)dis;
- (NSMutableArray *)selectAll;


@end
