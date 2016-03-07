//
//  RXMenuViewController.m
//  RTHXiOSAPengDai
//
//  Created by 赵鹏 on 16/3/5.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQMenuViewController.h"
#import "RXBasicItem.h"
#import "RXBasicArrowItem.h"
#import "RXBasicLabelItem.h"
#import "RXBasicSwitchItem.h"
#import "RXBasicTableViewCell.h"
#import "GradientView.h"
#import "UIViewController+MMDrawerController.h"
#import "QQMyFilesController.h"

static CGFloat const topview_height_rate = 0.3f;
static CGFloat const bottom_height       = 50.0f;

@interface QQMenuViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *datasArr;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation QQMenuViewController

-(id)init{
    self = [super init];
    if(self){
        [self setRestorationIdentifier:@"QQMenuViewController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAIN_THEME_COLOR;
    
    [self addCellItems];
    [self configTopView];
    [self configMiddleView];
    [self configBottomView];
    
    GradientView *blurView = [[GradientView alloc]initWithFrame:CGRectMake(0, (QQ_SCREENHEIGHT - bottom_height) * topview_height_rate, QQ_SCREENWIDTH * 0.8, 44) type:TRANSPARENT_ANOTHER_GRADIENT_TYPE];
    [self.view addSubview:blurView];
    // Do any additional setup after loading the view.
}

- (void)addCellItems{
    //    __weak typeof(self)weakSelf = self;
    UIImage *activityImg = [UIImage imageNamed:@"menu_exercise"];
    UIImage *messageImg  = [UIImage imageNamed:@"menu_message" ];
    UIImage *settingImg  = [UIImage imageNamed:@"menu_set"     ];
    UIImage *aboutImg    = [UIImage imageNamed:@"menu_about"   ];
    
    RXBasicArrowItem *member   = [RXBasicArrowItem  itemWithImage:activityImg title:@"开通会员"];
    RXBasicArrowItem *wallet   = [RXBasicArrowItem  itemWithImage:messageImg  title:@"QQ钱包" ];
    RXBasicArrowItem *playact  = [RXBasicArrowItem  itemWithImage:settingImg  title:@"个性装扮"];
    RXBasicArrowItem *collect  = [RXBasicArrowItem  itemWithImage:aboutImg    title:@"我的收藏"];
    RXBasicArrowItem *album    = [RXBasicArrowItem  itemWithImage:aboutImg    title:@"我的相册"];
    RXBasicArrowItem *files    = [RXBasicArrowItem  itemWithImage:aboutImg    title:@"我的文件"];
    
    self.datasArr = [NSMutableArray arrayWithObjects:@[member,wallet,playact,collect,album,files],nil];
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
    RXBasicTableViewCell *cell = [RXBasicTableViewCell cellWithTableView:tableView];
    NSArray *group = self.datasArr[indexPath.section];
    RXBasicItem *item = group[indexPath.row];
    cell.item = item;
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor colorWithRed:0/255.0 green:50/255.0 blue:130/255.0 alpha:1] : LISTVIEW_BACKGROUNDCOLOR;
    cell.backgroundColor = MAIN_THEME_COLOR;

    cell.textLabel.textColor = [UIColor whiteColor];
    cell.changeSelectBg = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    NSArray *group = self.datasArr[indexPath.section];
    RXBasicItem *item = group[indexPath.row];
    if (item.option != nil && ![item isKindOfClass:[RXBasicSwitchItem class]]) {
        item.option();
    }
    __weak typeof(self)weakSelf = self;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.imageView clearBadge];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.mm_drawerController setMaximumLeftDrawerWidth:QQ_SCREENWIDTH animated:YES completion:^(BOOL finished) {
        QQMyFilesController *vc = [[QQMyFilesController alloc]init];
        UINavigationController *nav = (UINavigationController *)weakSelf.mm_drawerController.centerViewController;
        vc.title = item.title;
        [nav pushViewController:vc animated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)( 0.25 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
            [weakSelf.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
                if (finished) {
                    [weakSelf.mm_drawerController setMaximumLeftDrawerWidth:QQ_SCREENWIDTH * 0.8];
                }
            }];
        });
    }];
}

- (NSMutableArray *)datasArr
{
    if (!_datasArr) {
        _datasArr = [NSMutableArray array];
    }
    return _datasArr;
}

#pragma mark - config subviews method

- (void)configTopView{
    CGFloat portraitH = 50;
    CGFloat nameLblH = 24;
    CGFloat portraitY = ((QQ_SCREENHEIGHT - bottom_height) * topview_height_rate - portraitH) * 0.5;
    CGFloat portraitX = 20;
    
    UIImageView *portrait = [[UIImageView alloc]initWithFrame:CGRectMake(portraitX, portraitY, portraitH, portraitH)];
    portrait.image = [UIImage imageNamed:@"menu_myaccount_icon"];
    [self.view addSubview:portrait];
    
    UIButton *qrCode = [[UIButton alloc]initWithFrame:CGRectMake(QQ_SCREENWIDTH * 0.8 - 20 - 40, portraitY, 40, 40)];
    [qrCode setImage:[UIImage imageNamed:@"menu_myaccount_icon"] forState:UIControlStateNormal];
    [self.view addSubview:qrCode];

    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(portrait.frame) + 10, portrait.top , QQ_SCREENWIDTH * 0.8, nameLblH)];
    nameLabel.text = @"zhaopeng";
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    UILabel *invitationCode = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(portrait.frame) , nameLabel.width - 40,
                                                                       (QQ_SCREENHEIGHT - bottom_height) * topview_height_rate - CGRectGetMaxY(portrait.frame) + 10)];
    invitationCode.text = @"jfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfjjfjosfj";
    invitationCode.textColor = [UIColor whiteColor];
    invitationCode.font = [UIFont systemFontOfSize:12];
    invitationCode.numberOfLines = 0;
    [self.view addSubview:invitationCode];
}

- (void)configMiddleView{
    CGFloat tableX = 0;
    CGFloat tableY = (QQ_SCREENHEIGHT - bottom_height) * topview_height_rate;
    CGFloat tableW = QQ_SCREENWIDTH * 0.8;
    CGFloat tableH = (QQ_SCREENHEIGHT - bottom_height) * (1 - topview_height_rate);
    CGRect tableFrame = CGRectMake(tableX, tableY, tableW, tableH);
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = MAIN_THEME_COLOR;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"menu_cell"];
    [self.view addSubview:tableView];
}

- (void)configBottomView{
    CGFloat labelW = (QQ_SCREENWIDTH * 0.8 - 60) * 0.5;
    UIButton *loginOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(20,
                                                                     QQ_SCREENHEIGHT - bottom_height,
                                                                     labelW,
                                                                      bottom_height)];
    [loginOutBtn setTitle:@"设置" forState:UIControlStateNormal];
//    [loginOutBtn setImage:[UIImage imageNamed:@"menu_quit"] forState:UIControlStateNormal];
    [self.view addSubview:loginOutBtn];
    [loginOutBtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 10, 0, 0)];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginOutBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [loginOutBtn addTarget:self action:@selector(loginOutButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginOutBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    UIButton *nightBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(loginOutBtn.frame),
                                                                      QQ_SCREENHEIGHT - bottom_height,
                                                                      labelW,
                                                                      bottom_height)];
    [nightBtn setTitle:@"夜间" forState:UIControlStateNormal];
//    [nightBtn setImage:[UIImage imageNamed:@"menu_quit"] forState:UIControlStateNormal];
    [self.view addSubview:nightBtn];
    [nightBtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 10, 0, 0)];
    nightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [nightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [nightBtn addTarget:self action:@selector(nightButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nightButtonDidClicked:(UIButton *)btn{
    
}

- (void)loginOutButtonDidClicked:(UIButton *)btn{
    __weak typeof(self)weakSelf = self;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出用户" message:@"确定退出用户吗?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:cancel];
    [alert addAction:ensure];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
