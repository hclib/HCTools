//
//  UIImage+Category.m
//  HCTools
//
//  Created by suhc on 16/3/9.
//  Copyright © 2016年 kongjianjia. All rights reserved.
//

#import "UIImage+Category.h"

@implementation UIImage (Category)

//通过颜色获取一个纯色UIImage
+ (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
