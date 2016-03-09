//
//  QQMessageController.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/8.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQRecentController.h"
#import "QQMessageTableController.h"
#import "QQPhoneTableController.h"
#import "UIViewController+MMDrawerController.h"
#import "AppDelegate.h"
#import "MMDrawerVisualState.h"

@interface QQRecentController () <UIScrollViewDelegate>

@property (weak, nonatomic) UISegmentedControl *segment;
@property (weak, nonatomic) UIScrollView       *container;
@property (weak, nonatomic) UIButton           *leftBtn;

@end

@implementation QQRecentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configRecentView];
    [self addSegmentControlView];
    [self addContainerScrollView];
    [self addContainerSubViews];
    // Do any additional setup after loading the view.
}

- (void)configRecentView{
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftBtn setImage:[UIImage imageNamed:@"IMG_0097"] forState:UIControlStateNormal];
    leftBtn.layer.cornerRadius = 20;
    leftBtn.adjustsImageWhenHighlighted = NO;
    [leftBtn addTarget:self action:@selector(leftButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.clipsToBounds = YES;
    _leftBtn = leftBtn;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    __weak typeof(self)weakSelf = self;
    [self.mm_drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         weakSelf.leftBtn.alpha = 1 - percentVisible;
         block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
}

- (void)leftButtonDidClicked:(UIButton *)btn{
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)addSegmentControlView{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"消息",@"电话"]];
    [segment setWidth:60 forSegmentAtIndex:0];
    [segment setWidth:60 forSegmentAtIndex:1];
    self.navigationItem.titleView = segment;
    _segment = segment;
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentSelectIndexChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentSelectIndexChanged:(UISegmentedControl *)segment{
    [_container setContentOffset:CGPointMake((segment.selectedSegmentIndex) * _container.width, 0) animated:NO];
}

- (void)addContainerScrollView{
    UIScrollView *container = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    container.delegate = self;
    container.contentSize = CGSizeMake(self.view.width, 0);
    [self.view addSubview:container];
    container.scrollEnabled = NO;
    _container = container;
}

- (void)addContainerSubViews{
    if (_container != nil) {
        UIStoryboard *messageSb = [UIStoryboard storyboardWithName:@"QQMessageTableController" bundle:nil];
        QQMessageTableController *message = messageSb.instantiateInitialViewController;
        [_container addSubview:message.view];
        [self addChildViewController:message];
        
        UIStoryboard *phoneSb = [UIStoryboard storyboardWithName:@"QQPhoneTableController" bundle:nil];
        QQMessageTableController *phone = phoneSb.instantiateInitialViewController;
        [_container addSubview:phone.view];
        phone.view.left = _container.width;
        [self addChildViewController:phone];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
