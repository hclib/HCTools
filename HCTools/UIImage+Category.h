//
//  UIImage+Category.h
//  HCTools
//
//  Created by suhc on 16/3/9.
//  Copyright © 2016年 kongjianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
/**
 *  根据颜色获取一个纯色UIImage
 *
 *  @param color 颜色
 *
 *  @return 生成的纯色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
