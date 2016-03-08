//
//  RTHXBasicTableViewCell.m
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/17.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import "RXBasicTableViewCell.h"
#import "RXBasicLabelItem.h"
#import "RXBasicArrowItem.h"
#import "RXBasicSwitchItem.h"

static const NSInteger DetailTextLabelFontSize = 14;

@interface RXBasicTableViewCell ()

@property (strong, nonatomic) UIImageView *arrowAccessoryView;
@property (strong, nonatomic) UISwitch    *switchAccessoryView;
@property (strong, nonatomic) UILabel     *labbelAccessoryView;
@property (strong, nonatomic) UIImageView *imgView;

@end

@implementation RXBasicTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *indentifier = @"Custom_Cell";
    RXBasicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[RXBasicTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_no"]];
    }
    return self;
}

- (void)setItem:(RXBasicItem *)item
{
    _item = item;
    self.imageView.image = item.image;
    self.textLabel.text  = item.title;
    self.detailTextLabel.text = item.subTitle;
    self.detailTextLabel.font = [UIFont systemFontOfSize:DetailTextLabelFontSize];
    _imgView.frame = CGRectMake(-18, 0, 13, 13);

    [self setupRightView];
    
    if (item.showWaring == NO) return;
    [_arrowAccessoryView addSubview:_imgView];
}

- (void)setupRightView
{
    if ([self.item isKindOfClass:[RXBasicArrowItem class]]) {
        self.accessoryView = self.arrowAccessoryView;
    }else if([self.item isKindOfClass:[RXBasicSwitchItem class]]){
        RXBasicSwitchItem *swItem = (RXBasicSwitchItem *)self.item;
        self.switchAccessoryView.on = NO;
        [self.switchAccessoryView addTarget:self action:@selector(switchState:) forControlEvents:UIControlEventValueChanged];
        self.switchAccessoryView.on = swItem.open;
        self.accessoryView = self.switchAccessoryView;
    }else if ([self.item isKindOfClass:[RXBasicLabelItem class]]){
        self.accessoryView = self.labbelAccessoryView;
    }else{
        self.accessoryView = nil;
    }
}
- (void)switchState:(UISwitch *)swt
{
    self.item.switchOption(swt);
}

#pragma mark - lazy
- (UIImageView *)arrowAccessoryView
{
    if (!_arrowAccessoryView) {
        _arrowAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right"]];
    }
    return _arrowAccessoryView;
}

- (UISwitch *)switchAccessoryView
{
    if (!_switchAccessoryView) {
        _switchAccessoryView = [[UISwitch alloc]init];
        _switchAccessoryView.onTintColor = ZP_COLOR(62, 163, 250, 1);
    }
    return _switchAccessoryView;
}

- (UILabel *)labbelAccessoryView
{
    if (!_labbelAccessoryView) {
        _labbelAccessoryView = [[UILabel alloc]init];
    }
    return _labbelAccessoryView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setChangeSelectBg:(BOOL)changeSelectBg{
    _changeSelectBg = changeSelectBg;
    if (_changeSelectBg && self.selectedBackgroundView != nil) {
        //设置选中状态下的Cell UI
        UIView *selectedView = [[UIView alloc]initWithFrame:self.contentView.frame];
        selectedView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        self.selectedBackgroundView = selectedView;
        self.textLabel.highlightedTextColor = [UIColor whiteColor];
    }
}

@end
