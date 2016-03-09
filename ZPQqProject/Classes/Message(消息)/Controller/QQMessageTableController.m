//
//  QQMessageTableController.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/8.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQMessageTableController.h"
#import "QQMessageCell.h"
#import "QQBasicItem.h"

@interface QQMessageTableController ()
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation QQMessageTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.height -= 113;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QQMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message_cell"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self)weakSelf = self;
    UITableViewRowAction *edit = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
//        [tableView reloadData];
    }];
    UITableViewRowAction *cancel = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakSelf.itemsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationNone];
    }];
    return @[cancel,edit];
}

- (NSMutableArray *)itemsArray{
    if (_itemsArray == nil) {
        _itemsArray = [NSMutableArray array];
        for (NSInteger index = 0; index < 20; index++) {
            QQBasicItem *item = [QQBasicItem itemWithImage:nil title:nil];
            [_itemsArray addObject:item];
        }
    }
    return _itemsArray;
}

@end
