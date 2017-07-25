//
//  UIView+Category.h
//  SpaceHome
//
//  Created by suhc on 2017/7/18.
//  Copyright © 2017年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)
#pragma mark - 设置frame
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;

#pragma mark - 设置圆角
/**
 设置上边圆角
*/
- (void)setCornerOnTop:(CGFloat) conner;
/**
 设置下边圆角
 */
- (void)setCornerOnBottom:(CGFloat) conner;
/**
 设置左边圆角
 */
- (void)setCornerOnLeft:(CGFloat) conner;
/**
 设置右边圆角
 */
- (void)setCornerOnRight:(CGFloat) conner;

/**
 设置左上圆角
 */
- (void)setCornerOnTopLeft:(CGFloat) conner;

/**
 设置右上圆角
 */
- (void)setCornerOnTopRight:(CGFloat) conner;
/**
 设置左下圆角
 */
- (void)setCornerOnBottomLeft:(CGFloat) conner;
/**
 设置右下圆角
 */
- (void)setCornerOnBottomRight:(CGFloat) conner;

/**
 设置所有圆角
 */
- (void)setCorner:(CGFloat) conner;

#pragma mark - 设置虚线边框
/**
 *  添加虚线边框(调用此方法前需要先设置frame)
 *
 *  @param borderWidth 边框宽度(虚线线条厚度)
 *  @param dashPattern @[@有色部分的宽度,@无色部分的宽度]
 *  @param color   虚线颜色
 */
- (void)addDashBorderWithWidth:(CGFloat)borderWidth dashPattern:(NSArray<NSNumber *> *)dashPattern color:(UIColor *)color;


/**
 获取当前view所在的controller
 */
- (UIViewController *)getController;

@end
