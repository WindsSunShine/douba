//
//  ActivityDetailViewController.m
//  Douban
//
//  Created by y_小易 on 14-8-27.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailView.h"
#import "ActivityModel.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "DBDB.h"

@interface ActivityDetailViewController ()

@property (nonatomic,retain) ActivityDetailView * detailView;
@property (nonatomic,retain) MBProgressHUD * hud;

//设置数据
- (void)p_setupData;
//设置返回按钮
- (void)p_setupSaveButtonItem;
//设置收藏按钮
- (void)p_setupFavoriteButtonItem;
//用户登录
- (void)p_userLogin;
//用户收藏活动
- (void)p_favoriteActivity;
//设置loading
- (void)p_setupProgressHud;
//移除alertView
- (void)p_removeAlertView:(UIAlertView *)alertView;

@end

@implementation ActivityDetailViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    self.detailView = [[[ActivityDetailView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _detailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.activity.title;
    
    //返回按钮
    [self p_setupSaveButtonItem];
    
    //设置收藏按钮
    [self p_setupFavoriteButtonItem];

    [self p_setupData];
}

//设置返回按钮
- (void)p_setupSaveButtonItem
{
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];

}

//设置收藏按钮
- (void)p_setupFavoriteButtonItem
{
    //收藏按钮
    UIBarButtonItem * favoriteButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_nav_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavoriteButtonItemAction:)];
    self.navigationItem.rightBarButtonItem = favoriteButtonItem;
    [favoriteButtonItem release];
}

//设置loading
- (void)p_setupProgressHud
{
    self.hud = [[[MBProgressHUD alloc] initWithView:self.view] autorelease];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_hud];
    
    [_hud show:YES];
}

#pragma mark -----控制方法-----
//返回
- (void)didClickBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}


//收藏
- (void)didClickFavoriteButtonItemAction:(UIBarButtonItem *)buttonItem
{
// 点击收藏
    BOOL islogin = [[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"];
    if (islogin) {
        // 收藏
        DBDB *manager = [DBDB manager];
        [manager openDB];
       [manager createActivityTable];
        BOOL isCreate = [manager insertActivity:self.activity];
        [manager closeDB];
        if (isCreate) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"好" message:@"收藏成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"不好" message:@"你已经收藏过了，不要重复收藏" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
        }
    }else {
        // 模态登录页面
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *loginNC = [[UINavigationController alloc]initWithRootViewController:loginVC];
        // 设置navigationBar
        loginNC.navigationBar.barTintColor = [UIColor colorWithRed:0.420 green:0.816 blue:0.869 alpha:1.000];
        [self presentViewController:loginNC animated:YES completion:nil];
    }
    
}

//用户登录
- (void)p_userLogin
{


}

//收藏活动
- (void)p_favoriteActivity
{
    

    
}

//移除alertView
- (void)p_removeAlertView:(UIAlertView *)alertView
{

}


#pragma mark -----显示数据-----
- (void)p_setupData
{
    ActivityDetailView *detailView = (ActivityDetailView *)self.view;
    [detailView setActivityModel:self.activity];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
