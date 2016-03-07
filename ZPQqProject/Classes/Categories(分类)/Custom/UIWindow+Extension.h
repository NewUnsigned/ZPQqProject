//
//  UIWindow+Extension.m
//  Extension
//
//  Created by zhaopeng on 15/4/11.
//  Copyright (c) 2015年 zhaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Extension)
// 切换根控制器
- (void)chooseRootVCWithRelogin:(BOOL)Relogin loginTimeOut:(BOOL)timeOut;
- (void)chooseRootViewController;

@end
