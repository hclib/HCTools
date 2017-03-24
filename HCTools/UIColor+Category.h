//
//  UIColor+Hex.h
//  funner
//
//  Created by suhc on 15/7/3.
//  Copyright (c) 2015年 ilinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

/**
 *  通过十六进制数生成颜色
 *
 *  @param hexColorString 十六进制字符串
 *
 *  @return 生成的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexColorString;

@end
