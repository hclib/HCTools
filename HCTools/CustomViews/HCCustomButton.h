//
//  CustomButton.h
//  test
//
//  Created by hclib on 2017/8/7.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HCCustomButtonTypeDefault = 0,        //文字在右边，图片在左边
    HCCustomButtonTypeImageOnRight,       //文字在左，图片在右边
    HCCustomButtonTypeImageOnTop,         //文字在下面，图片在上面
    HCCustomButtonTypeImageOnBottom,      //文字在上面，图片在下面
} HCCustomButtonType;

@interface HCCustomButton : UIButton

/**按钮类型*/
@property (nonatomic, assign) HCCustomButtonType type;

/**图片和文字之间的间隔*/
@property (nonatomic, assign) CGFloat padding;

/**
 初始化方法 (请使用此方法代替系统的buttonWithType:方法初始化控件)
 */
+ (instancetype)customButtonWithType:(HCCustomButtonType)type;

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

/**是否需要高亮状态(默认不需要高亮状态)*/
@property (nonatomic, assign, getter=isNeedHighlighted) BOOL needHighlighted;

@end
