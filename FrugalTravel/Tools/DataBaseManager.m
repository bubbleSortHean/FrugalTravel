//
//  DataBaseManager.m
//  FMDB
//
//  Created by Andy.He on 16/1/7.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import "DataBaseManager.h"
//#import "FMDatabase.h"
//#import "FMDatabaseQueue.h"
#import "FMDB.h"

@interface DataBaseManager ()
@property (nonatomic ,copy)NSString *filePath;
@property (nonatomic ,retain)FMDatabase *fmdb;
@end

@implementation DataBaseManager

+ (instancetype)shareDataBase{
    static dispatch_once_t t;
    static DataBaseManager *database = nil;
    dispatch_once(&t, ^{
        database = [[DataBaseManager alloc] init];
    });
    return database;
}

- (void)openDB{
    self.filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [self.filePath stringByAppendingPathComponent:@"student.sqlite"];
    NSLog(@"%@",self.filePath);
    // 创建一个fmdb对象
    self.fmdb = [FMDatabase databaseWithPath:self.filePath];
//    self.fmdb = [[FMDatabase alloc] initWithPath:self.filePath];
    BOOL result = [self.fmdb open];
    if (result) {
        NSLog(@"1");
    }
}

- (void)createTable{
    NSString *sqlStr = @"create table if not exists student1135(number integer primary key autoincrement, name text, sex text)";
    // 执行sql语句
    [self executeSql:sqlStr message:@"createTable"];
}
- (void)insert:(Student *)stu{
    NSString *sql = [NSString stringWithFormat:@"insert into student1135(name,sex) values('%@','%@')",stu.name,stu.sex];
    [self executeSql:sql message:@"插入"];
}
- (void)update:(Student *)stu{
    NSString *sql = [NSString stringWithFormat: @"update student1135 set name = '%@' where sex = '女' ",stu.name];
    [self executeSql:sql message:@"更新"];
}
- (void)deleteSql:(Student *)stu{
    NSString *sql = [NSString stringWithFormat:@"delete from student1135 where name = '李四'"];
    [self executeSql:sql message:@"删除"];
}
- (void)selectAll{
    NSString *sql = @"select * from student1135";
    FMResultSet *result = [self.fmdb executeQuery:sql];
    // 系统会把查询之后的值赋给result
    // 遍历
    while ([result next]) {
        NSString *name = [result stringForColumn:@"name"];
        NSString *sex = [result stringForColumn:@"sex"];
        NSLog(@"name %@ , sex %@",name ,sex);
    }
}
- (void)drop{
    NSString *sql = @"drop table student1135";
    [self executeSql:sql message:@"删除表"];
}
- (void)insertMoreStu:(Student *)stu{
    // 创建fmdb多线程对象,实现将多个对象放到子线程中,并且完成添加操作
    FMDatabaseQueue *queue = [[FMDatabaseQueue alloc] initWithPath:self.filePath];
    // 需要创建一个事物,然后把多个操作放到事务中执行
    // transaction就是事物的意思
    [queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = [NSString stringWithFormat:@"insert into student1135(name,sex) values('%@','%@')",stu.name,stu.sex];
        BOOL result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"1");
        }
        
    }];
}
- (void)executeSql:(NSString *)sql message:(NSString *)message{
    BOOL result = [self.fmdb executeUpdate:sql];
    if (result) {
        self.text = [NSString stringWithFormat:@"%@成功",message];
    }

}
@end
