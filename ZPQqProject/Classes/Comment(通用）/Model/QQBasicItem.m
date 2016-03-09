//
//  RTHXBasicItem.m
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/17.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import "QQBasicItem.h"

@implementation QQBasicItem

+ (instancetype)itemWithImage:(UIImage *)image title:(NSString *)title
{
    QQBasicItem *item = [[self alloc]init];
    item.image = image;
    item.title = title;
    return item;
}

@end
