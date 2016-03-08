//
//  RX_config.h
//  RXiOSApp
//
//  Created by 融通汇信 on 15/10/8.
//  Copyright © 2015年 融通汇信. All rights reserved.
//

#ifndef RX_config_h
#define RX_config_h

// MARK: 颜色工具
#define ZP_COLOR(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]

// 主题颜色
#define MAIN_THEME_COLOR [UIColor colorWithRed:(47/255.0) green:(158/255.0) blue:(255/255.0) alpha:1]
// 展示列表背景色
#define LISTVIEW_BACKGROUNDCOLOR [UIColor colorWithRed:(242/255.0) green:(246/255.0) blue:(248/255.0) alpha:1]

// 分割线颜色
#define SEPARATE_LINE_COLOR [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1]
// 还款中颜色
#define PROJECT_END_PROGRESS_COLOR [UIColor colorWithRed:(70/255.0) green:(170/255.0) blue:(255/255.0) alpha:1]
#define PROJECT_IVEST_PROGRESS_COLOR [UIColor colorWithRed:(100/255.0) green:(100/255.0) blue:(100/255.0) alpha:1]

#define LIST_TITLE_FONT  [UIFont fontWithName:@"Helvetica-Bold" size:14]

// 按钮高亮颜色,银行卡,交易密码
#define HIGHLIGHT_BUTTON_COLOR [UIColor lightGrayColor]

// MARK: 屏幕尺寸工具
#define QQ_SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define QQ_SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

// 系统版本
#define RX_IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#endif /* RX_config_h */
