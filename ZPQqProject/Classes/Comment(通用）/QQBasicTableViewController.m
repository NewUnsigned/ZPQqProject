//
//  RTHXBasicTableViewController.m
//  RTHXiOSApp
//
//  Created by 融通汇信 on 15/6/17.
//  Copyright (c) 2015年 融通汇信. All rights reserved.
//

#import "QQBasicItem.h"
#import "QQBasicArrowItem.h"
#import "QQBasicLabelItem.h"
#import "QQBasicSwitchItem.h"
#import "QQBasicTableViewCell.h"
#import "QQBasicTableViewController.h"

@interface QQBasicTableViewController ()
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation QQBasicTableViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LISTVIEW_BACKGROUNDCOLOR;
    self.tableView.showsVerticalScrollIndicator   = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *group = self.datasArr[section];
    return group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QQBasicTableViewCell *cell = [QQBasicTableViewCell cellWithTableView:tableView];
    NSArray *group = self.datasArr[indexPath.section];
    QQBasicItem *item = group[indexPath.row];
    cell.item = item;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    NSArray *group = self.datasArr[indexPath.section];
    QQBasicItem *item = group[indexPath.row];
    if (item.option != nil && ![item isKindOfClass:[QQBasicSwitchItem class]]) {
        item.option();
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.imageView clearBadge];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)datasArr
{
    if (!_datasArr) {
        _datasArr = [NSMutableArray array];
    }
    return _datasArr;
}


@end
