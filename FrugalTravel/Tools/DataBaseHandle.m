//
//  DataBaseHandle.m
//  FrugalTravel
//
//  Created by Andy.He on 16/2/27.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "DataBaseHandle.h"
#import "FMDB.h"

@interface DataBaseHandle ()

@property (nonatomic ,copy)NSString *filePath;
@property (nonatomic ,retain)FMDatabase *fmdb;

@end

@implementation DataBaseHandle


+ (instancetype)shareDataBase{
    static dispatch_once_t t;
    static DataBaseHandle *database = nil;
    dispatch_once(&t, ^{
        database = [[DataBaseHandle alloc] init];
        [database openDB];
        [database createTable];
    });
    return database;
}
- (void)openDB{
    self.filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [self.filePath stringByAppendingPathComponent:@"discount.sqlite"];
    // 创建一个fmdb对象
    self.fmdb = [FMDatabase databaseWithPath:self.filePath];
    BOOL result = [self.fmdb open];
    if (result) {
        NSLog(@"打开成功");
    }
}

- (void)createTable{
    NSString *sqlStr = @"create table if not exists discount(title text,departureTime text,pic text,price text,lastminute_des text,url text)";
    // 执行sql语句
    [self executeSql:sqlStr message:@"createTable"];
}

- (void)insert:(HA_discountModel *)dis{
    NSString *sql = [NSString stringWithFormat:@"insert into discount(title,departureTime,pic,price,lastminute_des,url) values('%@','%@','%@','%@','%@','%@')",dis.title,dis.departureTime,dis.pic,dis.price,dis.lastminute_des,dis.url];
    [self executeSql:sql message:@"插入"];
}

- (void)deleteSql:(HA_discountModel *)dis{
    NSString *sql = [NSString stringWithFormat:@"delete from discount where title = '%@'",dis.title];
    [self executeSql:sql message:@"删除"];
}

- (SelectStatus)selectInTable:(HA_discountModel *)dis{
    NSString *sqlStr = [NSString stringWithFormat:@"select * from discount where title = '%@'" ,dis.title];
    FMResultSet *result = [self.fmdb executeQuery:sqlStr];
    // 系统会把查询之后的值赋给result
    // 遍历
    while ([result next]) {
        NSString *title = [result stringForColumn:@"title"];
        if ([title isEqualToString:dis.title]) {
            return InTable;
        }
    }
    return NotInTable;
}

- (NSMutableArray *)selectAll{
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from discount"];
    FMResultSet *result = [self.fmdb executeQuery:sqlStr];
    NSMutableArray *arr = [NSMutableArray array];
    while ([result next]) {
        HA_discountModel *model = [[HA_discountModel alloc] init];
        model.title = [result stringForColumn:@"title"];
        model.pic = [result stringForColumn:@"pic"];
        model.departureTime = [result stringForColumn:@"departureTime"];
        model.lastminute_des = [result stringForColumn:@"lastminute_des"];
        model.price = [result stringForColumn:@"price"];
        model.url = [result stringForColumn:@"url"];
        [arr addObject:model];
    }
    return arr;
}

- (void)executeSql:(NSString *)sql message:(NSString *)message{
    BOOL result = [self.fmdb executeUpdate:sql];
    if (result) {
        self.text = [NSString stringWithFormat:@"%@成功",message];
        NSLog(@"%@",self.text);
    }
    
}

@end
