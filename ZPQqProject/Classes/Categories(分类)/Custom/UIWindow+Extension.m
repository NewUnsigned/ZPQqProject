//
//  UIWindow+Extension.m
//  Extension
//
//  Created by zhaopeng on 15/4/11.
//  Copyright (c) 2015年 zhaopeng. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "QQMainTabBarController.h"
//#import "RXLoginViewController.h"
#import "AppDelegate.h"
#import "QQMainNavigationController.h"

@implementation UIWindow (Extension)

- (void)chooseRootViewController
{
    [self chooseRootVCWithRelogin:NO loginTimeOut:NO];
}

- (void)chooseRootVCWithRelogin:(BOOL)Relogin loginTimeOut:(BOOL)timeOut
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewController *navRoot = [[UITableViewController alloc]init];
    navRoot.view.backgroundColor = [UIColor redColor];
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:navRoot];
    mainNav.navigationBar.hidden = YES;
    window.rootViewController = mainNav;
    window.backgroundColor = [UIColor whiteColor];
    
    QQMainTabbarController *mainTabBarVC = [[QQMainTabbarController alloc]init];
    [mainNav pushViewController:mainTabBarVC animated:YES];

    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSUserDefaults *dafault = [NSUserDefaults standardUserDefaults];
    NSString *sandboxVersion = [dafault objectForKey:@"RXiOSApp_Version"];
    if ([currentVersion compare:sandboxVersion] == NSOrderedDescending) {//NSOrderedDescending NSOrderedSame
        [dafault setObject:currentVersion forKey:@"RXiOSApp_Version"];
        [dafault synchronize];
//        mainTabBarVC.timeOut = NO;
//         mainTabBarVC.isRelogin = NO;
    }else{
//        mainTabBarVC.isRelogin = Relogin;
//        mainTabBarVC.timeOut = timeOut;
    }
}

@end
