//
//  QQMainNavigationController.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/7.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQMainNavigationController.h"

@interface QQMainNavigationController () <UIGestureRecognizerDelegate,UIViewControllerTransitioningDelegate>

@end

@implementation QQMainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTranslucent:NO];
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        weakSelf.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.enabled = YES;
            viewController.hidesBottomBarWhenPushed = YES;
        }
        [super pushViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - UIPanGestureRecognizer handlers

+ (void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
        [navBar setBackgroundImage:[UIImage imageWithColor:MAIN_THEME_COLOR] forBarMetrics:UIBarMetricsDefault];
    navBar.alpha = 1;
    navBar.translucent = NO;
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSForegroundColorAttributeName] = MAIN_THEME_COLOR;
    md[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    md[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:md];
}

@end
