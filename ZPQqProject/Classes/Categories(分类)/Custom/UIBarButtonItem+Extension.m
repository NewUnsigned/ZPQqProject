//
//  UIWindow+Extension.m
//  Extension
//
//  Created by zhaopeng on 15/4/11.
//  Copyright (c) 2015年 zhaopeng. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target type:(FlatButtonType)type action:(SEL)action
{
    // 1.创建一个按钮
    CGFloat width = 20;
    CGRect frame = CGRectMake(0, 0, width, width);
    VBFPopFlatButton *btn = [[VBFPopFlatButton alloc]initWithFrame:frame
                                                        buttonType:type
                                                       buttonStyle:buttonPlainStyle
                                             animateToInitialState:NO];
    
    btn.lineThickness = 2;
    btn.lineRadius = 1;
    btn.tintColor = [UIColor whiteColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTintColor:MAIN_THEME_COLOR forState:UIControlStateNormal];
    [btn setTintColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [btn setTintColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    // 5.根据按钮创建BarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  创建item
 *
 *  @param norimage 默认状态的图片
 *  @param higImage 高亮状态的图片
 *  @param title    标题
 *
 *  @return item
 */

+ (instancetype)itemWithNorImage:(NSString *)norimage higImage:(NSString *)higImage title:(NSString *)title target:(id)target action:(SEL)action
{
    // 1.创建一个按钮
    UIButton *btn = [[UIButton alloc] init];
    // 2.设置按钮的默认图片和高亮图片
    if (norimage != nil && ![norimage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:norimage] forState:UIControlStateNormal];
    }
    if (higImage != nil && ![higImage isEqualToString:@""]) {
        
        [btn setImage:[UIImage imageNamed:higImage] forState:UIControlStateHighlighted];
    }
    // 设置标题
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    // 3.监听按钮的点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 4.设置按钮的frame
    // 可以调用控件的sizeToFit方法来自动调整控件的大小
    [btn sizeToFit];
    //    btn.bounds = CGRectMake(0, 0, 35, 35);
    
    // 5.根据按钮创建BarButtonItem
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
#pragma clang diagnostic pop
@end
