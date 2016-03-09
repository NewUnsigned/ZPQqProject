//
//  QQMessageCell.m
//  ZPQqProject
//
//  Created by 融通汇信 on 16/3/8.
//  Copyright © 2016年 融通汇信. All rights reserved.
//

#import "QQMessageCell.h"

@implementation QQMessageCell

- (void)awakeFromNib {
    // Initialization code
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureCallback:)];
//    [self.contentView addGestureRecognizer:pan];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)panGestureCallback:(UIPanGestureRecognizer *)panGesture{
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            
            break;
        }
        case UIGestureRecognizerStateCancelled: {

            break;
        }
        default:
            break;
    }
}


@end
