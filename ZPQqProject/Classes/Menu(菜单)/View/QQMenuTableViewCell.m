//
//  QQMenuTableViewCell.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/9.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQMenuTableViewCell.h"
#import "QQBasicItem.h"

@implementation QQMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *indentifier = @"menu_table_cell";
    QQMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[QQMenuTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
        cell.backgroundColor = [UIColor clearColor];
        UIView *selectedView = [[UIView alloc]initWithFrame:cell.contentView.frame];
        selectedView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        cell.selectedBackgroundView = selectedView;
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    return cell;
}

- (void)setItem:(QQBasicItem *)item{
    _item = item;
    self.imageView.image = item.image;
    self.textLabel.text = item.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
