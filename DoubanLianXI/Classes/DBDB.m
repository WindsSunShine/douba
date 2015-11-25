
#import "DBDB.h"
#import <sqlite3.h>
#import "ActivityModel.h"
@implementation DBDB
// 单例
static DBDB *dbManager = nil;
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbManager = [[DBDB alloc]init];
    });
    return dbManager;
}
- (NSString *)cachesPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}
// 打开数据库
static sqlite3 *DB = nil;
- (BOOL)openDB {
    // 数据库路径
    NSString *sqlPath = [[self cachesPath]stringByAppendingPathComponent:@"douban.sqlite"];
    NSLog(@"%@",sqlPath);
    int result = sqlite3_open(sqlPath.UTF8String, &DB);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
        return YES;
    }else {
        NSLog(@"打开失败");
        return NO;
    }
}
// 关闭
- (BOOL)closeDB {
    int result = sqlite3_close(DB);
    if (result == SQLITE_OK) {
        return YES;
    }else {
        return NO;
    }
}
// 创建活动表
// 创建电影表
- (BOOL)createActivityTable {
    NSString *sql = @"CREATE TABLE IF NOT EXISTS activity (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, begin_time TEXT, end_time TEXT, address TEXT, category_name TEXT, wisher_count TEXT, participant_count TEXT, image TEXT, content TEXT, owner TEXT)";
    int result = sqlite3_exec(DB, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        return YES;
    }else {
        return NO;
    }
}
- (BOOL)createMovieTable {
    NSString *sql = @"CREATE TABLE IF NOT EXISTS movie (title TEXT PRIMARY KEY, movieObjc BLOB)";
    int result = sqlite3_exec(DB, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        return YES;
    }else {
        return NO;
    }
}
//判断有没有收藏过
-(BOOL)hasActivity:(ActivityModel*)activity{
    NSString *sql =[NSString  stringWithFormat:@"SELECT title FROM activity WHERE title = '%@'",activity.title];
    sqlite3_stmt *stmt =nil;
    int preResult =sqlite3_prepare(DB, sql.UTF8String, -1, &stmt, NULL);
    if (preResult == SQLITE_OK) {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            sqlite3_finalize(stmt);
            return YES;
        }
    }
    sqlite3_finalize(stmt);
    return NO;
    
}
// 插入新活动
- (BOOL)insertActivity:(ActivityModel *)activity {
    
    if ([self hasActivity:activity])  {
        NSLog(@"收藏过");
        return NO;
    }
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO activity (title, begin_time, end_time, address, category_name, wisher_count, participant_count, image, content, owner) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",activity.title,activity.begin_time,activity.end_time,activity.address,activity.category_name,activity.wisher_count.stringValue,activity.participant_count.stringValue,activity.image,activity.content,activity.owner];
    int result = sqlite3_exec(DB, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
        return YES;
        
    }else {
        NSLog(@"插入失败");
        return NO;
    }
}
// 查询所有收藏的活动
- (NSArray *)selectAllActivity {
    
    
    
    
    NSString *sql = @"SELECT title, begin_time, end_time, address, category_name, wisher_count, participant_count, image, content, owner FROM activity";
    sqlite3_stmt *stmt = nil;
    int preResult = sqlite3_prepare(DB, sql.UTF8String, -1, &stmt, NULL);
    NSMutableArray *activityArray = [[NSMutableArray alloc]init];
    if (preResult == SQLITE_OK) {
        NSLog(@"预执行成功");
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            ActivityModel *activity = [[ActivityModel alloc]init];
            activity.title = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            activity.begin_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            activity.end_time = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            activity.address = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            activity.category_name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            activity.wisher_count = [NSNumber numberWithInteger:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 5)].integerValue];
            activity.participant_count = [NSNumber numberWithInteger:[NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 6)].integerValue];
            activity.image = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 7)];
            activity.content = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 8)];
            activity.owner = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 9)];
            [activityArray addObject:activity];
        }
    }
    sqlite3_finalize(stmt);
    return activityArray;
}
@end
