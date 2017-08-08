//
//  UIImage+Category.h
//  SpaceHome
//
//  Created by suhc on 2017/7/19.
//  Copyright © 2017年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/**
 *  通过颜色获取一个纯色UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 获取系统竖屏启动页图片
 */
- (UIImage *)getPortraitLaunchImage;

/**
 获取系统横屏启动页图片
 */
- (UIImage *)getLandscapeLaunchImage;

@end
