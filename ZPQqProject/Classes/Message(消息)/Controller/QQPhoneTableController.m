//
//  QQPhoneTableController.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/8.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQPhoneTableController.h"

@interface QQPhoneTableController ()

@end

@implementation QQPhoneTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.height -= 113;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 10 : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = indexPath.section == 0 ? @"phone_cellq" : @"phone_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? 21 : 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel *secLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 21)];
        secLbl.font = [UIFont systemFontOfSize:10];
        secLbl.text = @"    通话记录";
        secLbl.textColor = [UIColor lightGrayColor];
        secLbl.backgroundColor = ZP_COLOR(232, 236, 238, 0.8);
        return secLbl;
    }else{
        return nil;
    }
}

@end
