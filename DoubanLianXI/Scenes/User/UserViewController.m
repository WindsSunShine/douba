//
//  UserViewController.m
//  DoubanLianXI
//
//  Created by 陈凯 on 15/10/15.
//  Copyright (c) 2015年 CK_. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"
#import "ActivityController.h"
@interface UserViewController ()<UIAlertViewDelegate>
// 声明数组属性
@property (nonatomic, strong) NSArray *userArray;
@end

@implementation UserViewController

// 重写getter方法
- (NSArray *)userArray {
    if (!_userArray) {
        _userArray = [[NSArray alloc]initWithObjects:@"我的活动",@"我的电影",@"清除缓存", nil];
    }
    return _userArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BOOL isLogin = [[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"];
    if (isLogin) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(clickUnLoginAction:)];
    }else {
        // 登录barButtonItem
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(clickLoginAction:)];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)clickLoginAction:(UIBarButtonItem *)barButtonItem {
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
    // 设置navigationBar
    loginNC.navigationBar.barTintColor = [UIColor colorWithRed:0.420 green:0.816 blue:0.869 alpha:1.000];

    [self presentViewController:loginNC animated:YES completion:nil];
}

// 注销
- (void)clickUnLoginAction:(UIBarButtonItem *)barButtonItem {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否确定注销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            // 取消
            break;
        case 1:
            // 确定
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            // 设置rightBarButtonItem为登录
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(clickLoginAction:)];
            
            break;
        default:
            break;
    }
}
/**
 *  点击 cell 方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            BOOL islogin =[[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"];
            if (islogin) {
                ActivityController *ac = [[ActivityController alloc]init];
                ac.isCollect = YES;
                ac.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:ac animated:YES];

            }else{
                [self clickLoginAction:nil];
            }
            
            
                   }
            break;
        case 1:
            
            break;
        case 2:
        {
            NSLog(@"清除缓存");
            NSString *caches=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        BOOL isCl=    [[NSFileManager defaultManager]removeItemAtPath:caches error:nil];
            if (isCl) {
                NSLog(@"清除成功");
            }else{
                NSLog(@"清除失败");
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.userArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *text = self.userArray[indexPath.row];
    cell.textLabel.text = text;
    return cell;
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
