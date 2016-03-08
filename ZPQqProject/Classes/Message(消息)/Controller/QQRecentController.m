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
    [leftBtn addTarget:self action:@selector(leftButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.clipsToBounds = YES;
    _leftBtn = leftBtn;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate addObserver:self forKeyPath:@"percentVisible" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

- (void)leftButtonDidClicked:(UIButton *)btn{
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    _leftBtn.alpha = 1 - [change[@"new"] floatValue];
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

- (void)dealloc{
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate removeObserver:self forKeyPath:@"frame"];
}

@end
