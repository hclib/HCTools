//
//  UIScrollView+Category.h
//  SpaceHome
//
//  Created by suhc on 2017/8/15.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Category)

/**
 自带伸缩功能的headerView
 如果是自定义view，需要把需要随着自定义view一起弹性缩放的subView设置autoresizingMask属性
 如果subView是UIImageView还需要设置contentMode = UIViewContentModeScaleAspectFill;
 */
@property (nonatomic, strong) UIView *zoomHeader;

@end
