//
//  LoginViewController.m
//  Douban
//
//  Created by y_小易 on 14-8-30.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegistViewController.h"
#import "LTView.h"

@interface LoginViewController ()

@property (nonatomic,retain) LoginView * loginView;//根视图
@end

@implementation LoginViewController
- (void)dealloc
{
    Block_release(_successBlock);
    self.loginView = nil;
    [super dealloc];
}

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
    self.loginView = [[[LoginView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.view = _loginView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"用户登陆";
    
    //导航栏的返回按钮
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackButtonItemAction:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [backButtonItem release];
    
    //登陆页面的登陆按钮添加响应方法
    [_loginView.loginButton addTarget:self action:@selector(didClickLoginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //登陆页面的注册按钮添加响应方法
    [_loginView.registButton addTarget:self action:@selector(didClickRegistButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //当从注册页面完成注册返回登陆页面时，根据用户的登陆状态，进行登陆成功回调，并退出登陆页面
    
    

        
        //推出登陆页面
//        [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

# pragma mark ------控制方法------
- (void)didClickBackButtonItemAction:(UIBarButtonItem *)buttonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didClickRegistButtonAction:(UIButton *)button
{
    //进入注册页面
    RegistViewController * registVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
    [registVC release];
}

//点击登陆按钮，验证用户登陆
- (void)didClickLoginButtonAction:(UIButton *)button
{

    //从沙盒中获取用户名和密码
    NSString *username = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
    //验证登陆
          //验证登陆成功，设置用户为登陆状态
    if ([self.loginView.usernameView.inputFieldText isEqualToString:username] && [self.loginView.passwordView.inputFieldText isEqualToString:password]) {
        NSLog(@"登录成功");
        // 存储登录状态
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        // 返回用户页
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        //登陆失败，显示提示框，停留在登陆页面
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"帐号或密码输入错误" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }
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
