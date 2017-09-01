//
//  UIButton+Category.h
//  hclib
//
//  Created by hclib on 2017/9/1.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Category)

/**
 设置不同状态下的背景颜色

 @param backgroundColor 背景颜色
 @param state 状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


/**
 设置不同状态下的字体

 @param font 字体
 @param state 状态
 */
- (void)setFont:(UIFont *)font forState:(UIControlState)state;

/**是否需要高亮状态*/
@property (nonatomic, assign, getter=isNeedHighlighted) BOOL needHighlighted;

@end
