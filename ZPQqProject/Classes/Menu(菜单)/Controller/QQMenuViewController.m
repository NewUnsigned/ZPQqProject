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
#import "QQNormalLevelView.h"

static CGFloat const topview_height_rate = 0.3f;
static CGFloat const menu_width_rate     = 0.85f;
static CGFloat const bottom_height       = 44.0f;

@interface QQMenuViewController () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *datasArr;
@property (nonatomic, strong) NSIndexPath    *indexPath;
@property (assign, nonatomic) CGFloat         menuWidth;
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
    
    [self configMenuView];
    [self addCellItems];
    [self configTopView];
    [self configMiddleView];
    [self configBottomView];
    
    // Do any additional setup after loading the view.
}

- (void)configMenuView{
    _menuWidth = QQ_SCREENWIDTH * menu_width_rate;
    self.view.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(185/255.0) blue:(250/255.0) alpha:1];
    
    UIImage *image = [UIImage imageNamed:@"sidebar_bg.jpg"];
    CGRect frame = CGRectMake(0, 0, _menuWidth, (QQ_SCREENHEIGHT - bottom_height) * 0.3 * 3.3 / 2);
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:frame];
    [self.view addSubview:imgView];
    imgView.contentMode = UIViewContentModeScaleToFill;
    [imgView setImage:image];
}

- (void)addCellItems{
    //    __weak typeof(self)weakSelf = self;
    UIImage *memberImg  = [UIImage imageNamed:@"sidebar_purse"     ];
    UIImage *walletImg  = [UIImage imageNamed:@"sidebar_purse"     ];
    UIImage *playactImg = [UIImage imageNamed:@"sidebar_decoration"];
    UIImage *collectImg = [UIImage imageNamed:@"sidebar_favorit"   ];
    UIImage *albumImg   = [UIImage imageNamed:@"sidebar_album"     ];
    UIImage *filesImg   = [UIImage imageNamed:@"sidebar_file"      ];
    
    RXBasicArrowItem *member   = [RXBasicArrowItem  itemWithImage:memberImg   title:@"开通会员"];
    RXBasicArrowItem *wallet   = [RXBasicArrowItem  itemWithImage:walletImg   title:@"QQ钱包" ];
    RXBasicArrowItem *playact  = [RXBasicArrowItem  itemWithImage:playactImg  title:@"个性装扮"];
    RXBasicArrowItem *collect  = [RXBasicArrowItem  itemWithImage:collectImg  title:@"我的收藏"];
    RXBasicArrowItem *album    = [RXBasicArrowItem  itemWithImage:albumImg    title:@"我的相册"];
    RXBasicArrowItem *files    = [RXBasicArrowItem  itemWithImage:filesImg    title:@"我的文件"];
    
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
//    RXBasicTableViewCell *cell = [RXBasicTableViewCell cellWithTableView:tableView];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu_cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menu_cell"];
    }
    NSArray *group = self.datasArr[indexPath.section];
    RXBasicItem *item = group[indexPath.row];
    cell.imageView.image = item.image;
    cell.textLabel.text = item.title;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    if (cell.selectedBackgroundView != nil) {
        UIView *selectedView = [[UIView alloc]initWithFrame:cell.contentView.frame];
        selectedView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
        cell.selectedBackgroundView = selectedView;
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    }
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.imageView clearBadge];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self closeDrawerWithTitle:item.title];
}
- (void)closeDrawerWithTitle:(NSString *)title{
    QQMyFilesController *vc = [[QQMyFilesController alloc]init];
    UINavigationController *nav = (UINavigationController *)self.mm_drawerController.centerViewController;
    vc.title = title;
    [nav pushViewController:vc animated:NO];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)( 0.25 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            if (finished) {
            }
        }];
    });
}

#pragma mark - config subviews method

- (void)configTopView{
    CGFloat portraitH = 50;
    CGFloat nameLblH = 24;
    CGFloat portraitY = ((QQ_SCREENHEIGHT - bottom_height) * topview_height_rate - portraitH) * 0.5;
    CGFloat portraitX = 20;
    
    UIImageView *portrait = [[UIImageView alloc]initWithFrame:CGRectMake(portraitX, portraitY, portraitH, portraitH)];
    portrait.image = [UIImage imageNamed:@"IMG_0097"];
    [self.view addSubview:portrait];
    portrait.clipsToBounds = YES;
    portrait.layer.borderWidth = 2;
    portrait.layer.borderColor = [UIColor whiteColor].CGColor;
    portrait.layer.cornerRadius = portraitH * 0.5;
    
    UIButton *qrCode = [[UIButton alloc]initWithFrame:CGRectMake(_menuWidth - 20 - 40, portraitY, 40, 40)];
    [qrCode setImage:[UIImage imageNamed:@"sidebar_QRcode_normal"] forState:UIControlStateNormal];
    [qrCode addTarget:self action:@selector(qrCodeButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [qrCode setImage:[UIImage imageNamed:@"sidebar_QRcode_press"] forState:UIControlStateHighlighted];
    [self.view addSubview:qrCode];

    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(portrait.frame) + 10, portrait.top , _menuWidth, nameLblH)];
    nameLabel.text = @"zhaopeng";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = LIST_TITLE_FONT;
    [self.view addSubview:nameLabel];
    
    CGRect frame = CGRectMake(nameLabel.left, CGRectGetMaxY(nameLabel.frame) + 5,nameLabel.width, nameLabel.height);
    QQNormalLevelView *levelView = [QQNormalLevelView levelViewWithFrame:frame sun:3 moon:3 star:3];
    [self.view addSubview:levelView];
    
    UIButton *signature = [[UIButton alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(portrait.frame) , nameLabel.width - 40,44)];
    NSString *text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    [signature setImage:[UIImage imageNamed:@"sidebar_signature_nor"] forState:UIControlStateNormal];
    [signature setTitle:text forState:UIControlStateNormal];
    [signature setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    signature.titleLabel.font = [UIFont systemFontOfSize:13];
    [signature setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    signature.adjustsImageWhenHighlighted = NO;
    [signature setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [signature addTarget:self action:@selector(signatureButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signature];
}

- (void)configMiddleView{
    CGFloat tableX = 0;
    CGFloat tableY = (QQ_SCREENHEIGHT - bottom_height) * topview_height_rate + 40;
    CGFloat tableW = _menuWidth;
    CGFloat tableH = (QQ_SCREENHEIGHT - bottom_height) * (1 - topview_height_rate) - 40;
    CGRect tableFrame = CGRectMake(tableX, tableY, tableW, tableH);
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"menu_cell"];
    [self.view addSubview:tableView];
}

- (void)configBottomView{
    CGFloat labelW = (_menuWidth - 60) * 0.3;
    UIButton *loginOutBtn = [[UIButton alloc]initWithFrame:CGRectMake(20,
                                                                     QQ_SCREENHEIGHT - bottom_height,
                                                                     labelW,
                                                                      bottom_height)];
    [loginOutBtn setTitle:@"设置" forState:UIControlStateNormal];
    [loginOutBtn setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
    [loginOutBtn setImage:[UIImage imageNamed:@"sidebar_setting_press"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:loginOutBtn];
    [loginOutBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    loginOutBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [loginOutBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [loginOutBtn addTarget:self action:@selector(loginOutButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginOutBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    UIButton *nightBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(loginOutBtn.frame) + 30,
                                                                      QQ_SCREENHEIGHT - bottom_height,
                                                                      labelW,
                                                                      bottom_height)];
    [nightBtn setTitle:@"夜间" forState:UIControlStateNormal];
    [nightBtn setImage:[UIImage imageNamed:@"sidebar_nightmode_off"] forState:UIControlStateNormal];
    [nightBtn setImage:[UIImage imageNamed:@"sidebar_nightmode_off_press"] forState:UIControlStateHighlighted];

    [self.view addSubview:nightBtn];
    [nightBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    nightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [nightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [nightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [nightBtn addTarget:self action:@selector(nightButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - button clicked method

- (void)nightButtonDidClicked:(UIButton *)btn{
    
}

- (void)qrCodeButtonDidClicked:(UIButton *)btn{
    [self closeDrawerWithTitle:@"二维码"];
}

- (void)signatureButtonDidClicked:(UIButton *)btn{
    [self closeDrawerWithTitle:@"修改签名"];
}

- (void)loginOutButtonDidClicked:(UIButton *)btn{
//    __weak typeof(self)weakSelf = self;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出用户" message:@"确定退出用户吗?" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:cancel];
    [alert addAction:ensure];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - lazy

- (NSMutableArray *)datasArr
{
    if (!_datasArr) {
        _datasArr = [NSMutableArray array];
    }
    return _datasArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
