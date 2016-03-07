//
//  CALayer+SLPopAddition.h
//  GlobalGuide
//
//  Created by 融通汇信 on 15/12/16.
//  Copyright © 2015年 Belle. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

extern NSString * const kRXLayerBackgroundColor;
extern NSString * const kRXLayerBounds;
extern NSString * const kRXLayerCornerRadius;
extern NSString * const kRXLayerBorderWidth;
extern NSString * const kRXLayerBorderColor;
extern NSString * const kRXLayerOpacity;
extern NSString * const kRXLayerPosition;
extern NSString * const kRXLayerPositionX;
extern NSString * const kRXLayerPositionY;
extern NSString * const kRXLayerRotation;
extern NSString * const kRXLayerRotationX;
extern NSString * const kRXLayerRotationY;
extern NSString * const kRXLayerScaleX;
extern NSString * const kRXLayerScaleXY;
extern NSString * const kRXLayerScaleY;
extern NSString * const kRXLayerSize;
extern NSString * const kRXLayerSubscaleXY;
extern NSString * const kRXLayerSubtranslationX;
extern NSString * const kRXLayerSubtranslationXY;
extern NSString * const kRXLayerSubtranslationY;
extern NSString * const kRXLayerSubtranslationZ;
extern NSString * const kRXLayerTranslationX;
extern NSString * const kRXLayerTranslationXY;
extern NSString * const kRXLayerTranslationY;
extern NSString * const kRXLayerTranslationZ;
extern NSString * const kRXLayerZPosition;
extern NSString * const kRXLayerShadowColor;
extern NSString * const kRXLayerShadowOffset;
extern NSString * const kRXLayerShadowOpacity;
extern NSString * const kRXLayerShadowRadius;

typedef void(^RXPopComplete)(id obj, BOOL finish);

typedef NS_ENUM(NSInteger, SharkeDirection){
    SharkeDirectionLeft = -1,
    SharkeDirectionRight = 1,
};

@interface CALayer (RXPopAddition)

// MARK: BASIC
/**
 *  Add an basic animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */

- (void)rx_basicWithName:(NSString *)propertyNamed to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(RXPopComplete)complete;

/**
 *  Add an basic animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param fromeValue    original value
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */
- (void)rx_basicWithName:(NSString *)name from:(id)fromValue to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(RXPopComplete)complete;

// MARK: SPRING
/**
 *  Add an spring animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */

- (void)rx_springWithName:(NSString *)propertyNamed to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(RXPopComplete)complete;

/**
 *  Add an spring animation to the reciver.
 *
 *  @param propertyNamed The name of the animatable property.
 *  @param fromeValue    original value
 *  @param toValue       destination value
 *  @param bounce        The effective bounciness.
 *  @param speed         The effective speed.
 *  @param key           The 'key' may be any string such that only one animation per unique key is added per object.
 *  @param complete      Optional block called on animation completion.
 */
- (void)rx_springWithName:(NSString *)propertyNamed from:(id)fromValue to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(RXPopComplete)complete;

/**
 @abstract Remove all animations attached to the receiver.
 */
- (void)rx_removeAllAnimations;

- (void)rx_shake;

- (void)rx_shakeWithDirection:(SharkeDirection)direction;

@end
