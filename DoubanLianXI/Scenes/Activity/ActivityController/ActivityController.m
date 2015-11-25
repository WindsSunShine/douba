//
//  ActivityController.m
//  DoubanLianXI
//
//  Created by 陈凯 on 15/10/9.
//  Copyright (c) 2015年 CK_. All rights reserved.
//

#import "ActivityController.h"
#import "ActivityModel.h"
#import "ActivityCell.h"
#import "ActivityDetailViewController.h"
#import "MBProgressHUD.h"
#import "DBDB.h"
#define ActivityURL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php"
@interface ActivityController ()
// 存储活动列表
@property (nonatomic, strong) NSMutableArray *activityArray;
@end


@implementation ActivityController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.activityArray = [[NSMutableArray alloc]init];
    [self.tableView registerClass:[ActivityCell class] forCellReuseIdentifier:@"activity"];
    if (self.isCollect) {
        [self getDataFromSQL];
    }else {
        [self requestData];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

// 网络请求
- (void)requestData {
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];

    // 创建网址对象
    NSURL *url = [NSURL URLWithString:ActivityURL];
    // 创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 获取单例
    NSURLSession *session = [NSURLSession sharedSession];
    // 设置sessionDataTask请求Request
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"请求数据出错");
            return;
        }
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *eventsArray = jsonDict[@"events"];
        // 遍例活动数组
        for (NSDictionary *activityDict in eventsArray) {
            ActivityModel *activity = [[ActivityModel alloc]init];
            [activity setValuesForKeysWithDictionary:activityDict];
            [self.activityArray addObject:activity];
        }
        // 子线程无法更新UI
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];

        [progressHUD performSelectorOnMainThread:@selector(hide:) withObject:nil waitUntilDone:YES];
    }];
    // 执行请求
    [dataTask resume];
}

- (void)getDataFromSQL {
    // 获数据库中的数据
    DBDB *manager = [DBDB manager];
    [manager openDB];
    [manager createActivityTable];
    NSArray *array = [manager selectAllActivity];
    [manager closeDB];
    [self.activityArray addObjectsFromArray:array];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.activityArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activity" forIndexPath:indexPath];
    ActivityModel *activity = self.activityArray[indexPath.row];
    cell.activity = activity;
    // Configure the cell...
    
    return cell;
}

// 设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

// 点击跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc]init];
    
    ActivityModel *activity = self.activityArray[indexPath.row];
    detailVC.activity = activity;
    detailVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
