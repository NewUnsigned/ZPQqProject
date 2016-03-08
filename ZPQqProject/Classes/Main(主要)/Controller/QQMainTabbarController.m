//
//  QQMainTabbarController.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/7.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQMainTabbarController.h"
#import "UIViewController+MMDrawerController.h"
#import "QQContactsController.h"
#import "QQTrendstTableController.h"
#import "QQMessageTableController.h"
#import "QQMainNavigationController.h"

@interface QQMainTabbarController () <UITabBarControllerDelegate>

@end

@implementation QQMainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.tabBar setTintColor:MAIN_THEME_COLOR];
    [self.tabBar setBarTintColor:ZP_COLOR(234, 235, 237, 1)];
    [self addChildViewcontrollers];

    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUnreadMessageNumbers) name:RXUserLoginInSuccess object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tabBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setOpenAndCloseDrawerGestureModeWithEffect:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setOpenAndCloseDrawerGestureModeWithEffect:NO];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setOpenAndCloseDrawerGestureModeWithEffect:![[change objectForKey:@"new"] boolValue]];
}

- (void)addChildViewcontrollers
{
    [self addChildvcWithSbName:@"QQMessageTableController"
                         title:@"消息"
                   normalImage:@"tab_recent_nor"
                 selectedImage:@"tab_recent_press"];
    [self addChildvcWithSbName:@"QQContactsController"
                         title:@"联系人"
                   normalImage:@"tab_buddy_nor"
                 selectedImage:@"tab_buddy_press"];
    [self addChildvcWithSbName:@"QQTrendstTableController"
                         title:@"动态"
                   normalImage:@"tab_qworld_nor"
                 selectedImage:@"tab_qworld_press"];
}

- (UIViewController *)addChildVCWithClass:(Class)class title:(NSString *)title norImageName:(NSString *)norImageName selectedImageName:(NSString *)selectedImageName
{
    UIViewController *vc = [[class alloc] init];
    QQMainNavigationController *nav = [[QQMainNavigationController alloc]init];
    [nav addChildViewController:vc];
    return  [self addChildVCWithController:vc title:title norImageName:norImageName selectedImageName:selectedImageName];
}

- (UIViewController *)addChildvcWithSbName:(NSString *)sbName title:(NSString *)title normalImage:(NSString *)normal selectedImage:(NSString *)selected
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UINavigationController *nav = sb.instantiateInitialViewController;
    [self addChildVCWithController:nav.topViewController title:title norImageName:normal selectedImageName:selected];
    return nav.topViewController;
}

- (UIViewController *)addChildVCWithController:(UIViewController *)vc  title:(NSString *)title norImageName:(NSString *)norImageName selectedImageName:(NSString *)selectedImageName{
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:norImageName];
    vc.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImageName];
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x606060"]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MAIN_THEME_COLOR} forState:UIControlStateSelected];
    [self addChildViewController:vc.navigationController];
    return vc;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //    if (viewController == [tabBarController.viewControllers objectAtIndex:2])
    //    {
    //        if ([[RXAccountManager shareManager] isLogin]) return YES;
    //
    //        return NO;
    //    }else {
    //        return YES;
    //    }
    return YES;
}

- (void)setOpenAndCloseDrawerGestureModeWithEffect:(BOOL)effect{
    if (effect) {
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeBezelPanningCenterView];
        [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModePanningCenterView | MMCloseDrawerGestureModeTapCenterView];
    }else{
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
        [self.mm_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];
    }
}

- (void)dealloc{
    [self.tabBar removeObserver:self forKeyPath:@"hidden"];
}

@end
