

#import <Foundation/Foundation.h>
@class ActivityModel;
@interface DBDB : NSObject
// 单例
+ (instancetype)manager;
// 打开数据库
- (BOOL)openDB;
// 关闭
- (BOOL)closeDB;
// 创建活动表
// 创建电影表
- (BOOL)createActivityTable;
- (BOOL)createMovieTable;
// 插入新活动
- (BOOL)insertActivity:(ActivityModel *)activity;
// 查询所有收藏的活动
- (NSArray *)selectAllActivity;

@end
