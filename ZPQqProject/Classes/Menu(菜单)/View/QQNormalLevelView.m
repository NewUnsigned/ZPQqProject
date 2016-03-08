//
//  QQNormalLevelView.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/8.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQNormalLevelView.h"

static CGFloat const width = 15.0f;

@implementation QQNormalLevelView

+ (instancetype)levelViewWithFrame:(CGRect)frame sun:(NSUInteger)sunNum moon:(NSUInteger)moonNum star:(NSUInteger)starNum{
    QQNormalLevelView *level = [[QQNormalLevelView alloc]initWithFrame:frame];
    
    [level addSunWithSun:sunNum];
    [level addMoonWithMoon:moonNum sun:sunNum];
    [level addStarWithStar:starNum sun:sunNum moon:moonNum];
    
    return level;
}

- (void)addSunWithSun:(NSUInteger)sunNum{
    [self addImageWithName:@"usersummary_icon_lv_sun" imgNum:sunNum addtionNum:0];
}

- (void)addMoonWithMoon:(NSUInteger)moonNum sun:(NSUInteger)sunNum{
    [self addImageWithName:@"usersummary_icon_lv_moon" imgNum:moonNum addtionNum:sunNum];
}

- (void)addStarWithStar:(NSUInteger)starNum sun:(NSUInteger)sunNum moon:(NSUInteger)moonNum{
    [self addImageWithName:@"usersummary_icon_lv_star" imgNum:starNum addtionNum:sunNum + moonNum];
}

- (void)addImageWithName:(NSString *)imgName imgNum:(NSUInteger)num addtionNum:(NSUInteger)addtion{
    CGFloat imgY = 0;
    CGFloat imgW = width;
    CGFloat imgH = width;
    
    for (NSUInteger index = 0; index < num; index++) {
        CGFloat imgX = (addtion + index) * width;
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(imgX, imgY, imgW, imgH)];
        img.image = [UIImage imageNamed:imgName];
        [self addSubview:img];
    }
}

@end
