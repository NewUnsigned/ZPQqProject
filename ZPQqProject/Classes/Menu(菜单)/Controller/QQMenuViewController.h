//
//  RXMenuViewController.h
//  RTHXiOSAPengDai
//
//  Created by 赵鹏 on 16/3/5.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QQMenuViewController;

@protocol QQMenuViewControllerDelegate <NSObject>

- (void)menuViewController:(QQMenuViewController *)menuVC selectedCellWithTitle:(NSString *)title;

@end

@interface QQMenuViewController : UIViewController

@property (weak, nonatomic) id<QQMenuViewControllerDelegate> delegate;

@end
