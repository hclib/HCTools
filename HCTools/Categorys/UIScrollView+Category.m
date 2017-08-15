//
//  UIScrollView+Category.m
//  SpaceHome
//
//  Created by suhc on 2017/8/15.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import "UIScrollView+Category.h"
#import <objc/runtime.h>

#define K_ContentOffset @"contentOffset"
@implementation UIScrollView (Category)

- (void)setZoomHeader:(UIView *)zoomHeader{
    objc_setAssociatedObject(self, @selector(zoomHeader), zoomHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.contentInset = UIEdgeInsetsMake(zoomHeader.frame.size.height, 0, 0, 0);
    [self insertSubview:zoomHeader atIndex:0];
    [self addObserver:self forKeyPath:K_ContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [self setContentOffset:CGPointMake(0, -self.contentInset.top)];
    
    zoomHeader.contentMode = UIViewContentModeScaleAspectFill;
    zoomHeader.clipsToBounds = YES;
    [self reSizeView:zoomHeader];
}

- (UIView *)zoomHeader{
    return objc_getAssociatedObject(self, @selector(zoomHeader));
}

- (void)reSizeView:(UIView *)zoomHeader{
    CGFloat width = zoomHeader.frame.size.width;
    CGFloat height = self.contentInset.top;
    [zoomHeader setFrame:CGRectMake(0, -height, width, height)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (![keyPath isEqualToString:K_ContentOffset]) {
        return;
    }
    [self _scrollViewDidScroll:self];
}

- (void)_scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    UIView *zoomHeader = scrollView.zoomHeader;
    if(offsetY < -scrollView.contentInset.top) {
        CGRect currentFrame = zoomHeader.frame;
        currentFrame.origin.y = offsetY;
        currentFrame.size.height = -offsetY;
        scrollView.zoomHeader.frame = currentFrame;
    }else{
        [self reSizeView:zoomHeader];
    }
}

@end
