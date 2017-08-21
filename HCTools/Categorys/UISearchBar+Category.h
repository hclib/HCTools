//
//  UISearchBar+Category.h
//  hclib
//
//  Created by hclib on 2017/8/21.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (Category)

/**文字颜色*/
@property (nonatomic, strong) UIColor *textColor;

/**placeholder颜色,需要先设置placeholder*/
@property (nonatomic, strong) UIColor *placeholderColer;

/**字体大小*/
@property (nonatomic, strong) UIFont *font;

/**背景颜色*/
@property (nonatomic, strong) UIColor *bgColor;

/**
 设置搜索图标

 @param searchIcon 图标
 @param state 对应的状态
 */
- (void)setSearchIcon:(UIImage *)searchIcon state:(UIControlState)state;


@end
