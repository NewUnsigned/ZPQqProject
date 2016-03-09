//
//  QQMenuTableViewCell.h
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/9.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RXBasicItem;

@interface QQMenuTableViewCell : UITableViewCell
@property (strong, nonatomic) RXBasicItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
