//
//  UIColor+Category.h
//  SpaceHome
//
//  Created by suhc on 2017/7/19.
//  Copyright © 2017年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/**
 通过十六进制数生成颜色

 @param hexColorString 十六进制字符串
 @return 生成的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;

/**
 通过十六进制数生成颜色

 @param hexColorString 十六进制字符串
 @param alpha 透明度
 @return 生成的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString alpha:(CGFloat)alpha;

@end
