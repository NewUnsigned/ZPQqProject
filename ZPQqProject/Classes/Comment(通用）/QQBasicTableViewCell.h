//
//  RTHXBasicTableViewCell.h
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/17.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQBasicItem.h"
#import "UIView+WZLBadge.h"

@interface QQBasicTableViewCell : UITableViewCell

@property (strong, nonatomic) QQBasicItem *item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (assign, nonatomic) BOOL changeSelectBg;

@end
