//
//  RTHXBasicItem.h
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/17.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+WZLBadge.h"

typedef void (^myOption)();
typedef void (^switchOption)(UISwitch *);

@interface RXBasicItem : NSObject
@property (strong, nonatomic) UIImage *image;///图片
@property (copy, nonatomic)  NSString *title;
@property (copy, nonatomic)  NSString *subTitle;
@property (copy, nonatomic)  myOption option;
@property (copy, nonatomic) switchOption switchOption;
@property (assign, nonatomic) BOOL showWaring;

/**
 *  快速创建item
 *
 *  @param image 图片
 *  @param title 标题
 *
 *  @return item对象
 */
+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title;
@end
