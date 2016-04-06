//
//  DataBaseManager.h
//  FMDB
//
//  Created by Andy.He on 16/1/7.
//  Copyright © 2016年 Andy.He. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject

@property(nonatomic ,copy)NSString *text;

+ (instancetype)shareDataBase;
- (void)openDB;
- (void)createTable;
- (void)insert:(Student *)stu;
- (void)update:(Student *)stu;
- (void)deleteSql:(Student *)stu;
- (void)selectAll;
- (void)drop;
// 添加多个学生
- (void)insertMoreStu:(Student *)stu;

@end
