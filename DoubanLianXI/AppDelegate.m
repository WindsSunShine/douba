
#import "AppDelegate.h"
#import "ActivityController.h"
#import "UserViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@",NSHomeDirectory());
    // Override point for customization after application launch.
    // 创建window
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    // 设置子视图控制器、navigationController
    ActivityController *AC = [[ActivityController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *activityNC = [[UINavigationController alloc]initWithRootViewController:AC];
    // 设置navigationBar
    activityNC.navigationBar.barTintColor = [UIColor colorWithRed:0.420 green:0.816 blue:0.869 alpha:1.000];
    AC.title = @"活动";
    AC.tabBarItem.image = [UIImage imageNamed:@"activity"];
    
    /**
     创建子视图控制器
     
     */
    // 设置子视图控制器、navigationController
    UIViewController *MC = [[UIViewController alloc]init];
    UINavigationController *movieNC = [[UINavigationController alloc]initWithRootViewController:MC];
    // 设置navigationBar
    movieNC.navigationBar.barTintColor = [UIColor colorWithRed:0.420 green:0.816 blue:0.869 alpha:1.000];
    MC.title = @"电影";
    MC.tabBarItem.image = [UIImage imageNamed:@"movie"];

    // 设置子视图控制器、navigationController
    UIViewController *CC = [[UIViewController alloc]init];
    UINavigationController *cinemaNC = [[UINavigationController alloc]initWithRootViewController:CC];
    // 设置navigationBar
    cinemaNC.navigationBar.barTintColor = [UIColor colorWithRed:0.420 green:0.816 blue:0.869 alpha:1.000];
    CC.title = @"影院";
    CC.tabBarItem.image = [UIImage imageNamed:@"cinema"];

    // 设置子视图控制器、navigationController
    UserViewController *UC = [[UserViewController alloc]initWithStyle:UITableViewStylePlain];
    UINavigationController *userNC = [[UINavigationController alloc]initWithRootViewController:UC];
    // 设置navigationBar
    userNC.navigationBar.barTintColor = [UIColor colorWithRed:0.420 green:0.816 blue:0.869 alpha:1.000];
    UC.title = @"我的";
    UC.tabBarItem.image = [UIImage imageNamed:@"user"];

    
    // tabbarController
    UITabBarController *rootTBC = [[UITabBarController alloc]init];
    rootTBC.viewControllers = @[activityNC,movieNC,cinemaNC,userNC];
    self.window.rootViewController = rootTBC;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
