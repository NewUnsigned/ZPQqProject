//
//  RTHXBasicTableViewCell.h
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/17.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXBasicItem.h"
#import "UIView+WZLBadge.h"

@interface RXBasicTableViewCell : UITableViewCell

@property (strong, nonatomic) RXBasicItem *item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (assign, nonatomic) BOOL changeSelectBg;

@end
