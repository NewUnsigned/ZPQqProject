//
//  CALayer+SLPopAddition.m
//  GlobalGuide
//
//  Created by 融通汇信 on 15/12/16.
//  Copyright © 2015年 Belle. All rights reserved.
//

#import "CALayer+RXPopAddition.h"
#import "POP.h"

NSString * const kRXLayerBackgroundColor        = @"backgroundColor";
NSString * const kRXLayerBounds                 = @"bounds";
NSString * const kRXLayerCornerRadius           = @"cornerRadius";
NSString * const kRXLayerBorderWidth            = @"borderWidth";
NSString * const kRXLayerBorderColor            = @"borderColor";
NSString * const kRXLayerOpacity                = @"opacity";
NSString * const kRXLayerPosition               = @"position";
NSString * const kRXLayerPositionX              = @"positionX";
NSString * const kRXLayerPositionY              = @"positionY";
NSString * const kRXLayerRotation               = @"rotation";
NSString * const kRXLayerRotationX              = @"rotationX";
NSString * const kRXLayerRotationY              = @"rotationY";
NSString * const kRXLayerScaleX                 = @"scaleX";
NSString * const kRXLayerScaleXY                = @"scaleXY";
NSString * const kRXLayerScaleY                 = @"scaleY";
NSString * const kRXLayerSize                   = @"size";
NSString * const kRXLayerSubscaleXY             = @"subscaleXY";
NSString * const kRXLayerSubtranslationX        = @"subtranslationX";
NSString * const kRXLayerSubtranslationXY       = @"subtranslationXY";
NSString * const kRXLayerSubtranslationY        = @"subtranslationY";
NSString * const kRXLayerSubtranslationZ        = @"subtranslationZ";
NSString * const kRXLayerTranslationX           = @"translationX";
NSString * const kRXLayerTranslationXY          = @"translationXY";
NSString * const kRXLayerTranslationY           = @"translationY";
NSString * const kRXLayerTranslationZ           = @"translationZ";
NSString * const kRXLayerZPosition              = @"zPosition";
NSString * const kRXLayerShadowColor            = @"shadowColor";
NSString * const kRXLayerShadowOffset           = @"shadowOffset";
NSString * const kRXLayerShadowOpacity          = @"shadowOpacity";
NSString * const kRXLayerShadowRadius           = @"shadowRadius";

@implementation CALayer (RXPopAddition)

// MARK: BASIC

- (void)rx_basicWithName:(NSString *)name to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(RXPopComplete)complete{
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:name];
    basicAnimation.toValue   = toValue;
    basicAnimation.duration = duration;
    basicAnimation.completionBlock = complete;
    [self pop_addAnimation:basicAnimation forKey:key];
}

- (void)rx_basicWithName:(NSString *)name from:(id)fromValue to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(RXPopComplete)complete{
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:name];
    basicAnimation.toValue   = toValue;
    basicAnimation.fromValue = fromValue;
    basicAnimation.duration = duration;
    basicAnimation.completionBlock = complete;
    [self pop_addAnimation:basicAnimation forKey:key];
}

// MARK: SPRING

- (void)rx_springWithName:(NSString *)propertyNamed to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(RXPopComplete)complete{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:propertyNamed];
    springAnimation.toValue    = toValue;
    springAnimation.springBounciness = bounce;
    springAnimation.springSpeed = speed;
    springAnimation.completionBlock = complete;
    [self pop_addAnimation:springAnimation forKey:key];
}

- (void)rx_springWithName:(NSString *)propertyNamed from:(id)fromValue to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(RXPopComplete)complete{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:propertyNamed];
    springAnimation.fromValue  = fromValue;
    springAnimation.toValue    = toValue;
    springAnimation.springBounciness = bounce;
    springAnimation.springSpeed = speed;
    springAnimation.completionBlock = complete;
    [self pop_addAnimation:springAnimation forKey:key];
}

- (void)rx_removeAllAnimations{
    [self pop_removeAllAnimations];
}

/*
 *  摇动
 */
-(void)rx_shake{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 5;
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    //时长
    kfa.duration = 0.3f;
    //重复
    kfa.repeatCount = 2;
    //移除
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"shake"];
}

-(void)rx_shakeWithDirection:(SharkeDirection)direction{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = direction * 5;
    kfa.values = @[@(0),@(-s),@(s),@(-s),@(0)];
    //时长
    kfa.duration = 0.5f;
    //重复
    kfa.repeatCount = 1;
    //移除
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"shake"];
}

@end
