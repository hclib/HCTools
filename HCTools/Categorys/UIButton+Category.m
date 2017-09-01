//
//  UIButton+Category.m
//  hclib
//
//  Created by hclib on 2017/9/1.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import "UIButton+Category.h"
#import <objc/runtime.h>

#pragma mark Attribute
@interface UIButtonAttribute : NSObject

/**背景颜色*/
@property (nonatomic, strong) UIColor *backgroundColor;

/**状态*/
@property (nonatomic, strong) NSNumber *state;

/**字体*/
@property (nonatomic, strong) UIFont *font;

@end

@implementation UIButtonAttribute

@end

@implementation UIButton (Category)

+ (void)load{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^
                  {
                      SEL swizzleSelectors[3] = {
                          @selector(touchesEnded:withEvent:),
                          @selector(touchesMoved:withEvent:),
                          @selector(removeFromSuperview)
                      };
                      for (int i = 0; i < 3;  i++) {
                          
                          SEL selector = swizzleSelectors[i];
                          
                          NSString *newSelectorStr = [NSString stringWithFormat:@"easy_%@", NSStringFromSelector(selector)];
                          
                          Method originMethod = class_getInstanceMethod(self, selector);
                          
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

#pragma mark - 属性
- (void)set_state:(UIControlState)_state{
    objc_setAssociatedObject(self, @selector(_state), @(_state), OBJC_ASSOCIATION_ASSIGN);
}

- (UIControlState)_state{
    return [objc_getAssociatedObject(self, @selector(_state)) integerValue];
}

- (void)setHasObserver:(BOOL)hasObserver{
    objc_setAssociatedObject(self, @selector(hasObserver), @(hasObserver), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hasObserver{
    return [objc_getAssociatedObject(self, @selector(hasObserver)) integerValue];
}

- (void)setAttributes:(NSMutableArray *)attributes{
    objc_setAssociatedObject(self, @selector(attributes), attributes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)attributes{
    return objc_getAssociatedObject(self, @selector(attributes));
}

- (void)setNeedHighlighted:(BOOL)needHighlighted{
    objc_setAssociatedObject(self, @selector(isNeedHighlighted), @(needHighlighted), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isNeedHighlighted{
    return objc_getAssociatedObject(self, @selector(isNeedHighlighted));
}

#pragma mark - public method
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state{
    [self _setBackgroundColor:backgroundColor font:nil forState:state];
}

- (void)setFont:(UIFont *)font forState:(UIControlState)state{
    [self _setBackgroundColor:nil font:font forState:state];
}

#pragma mark - private method
- (void)_setBackgroundColor:(UIColor *)backgroundColor font:(UIFont *)font forState:(UIControlState)state{
    if (state == UIControlStateNormal) {
        if (backgroundColor) {
            self.backgroundColor = backgroundColor;
        }
        if (font) {
            self.titleLabel.font = font;
        }
    }
    if (![self hasObserver]) {
        [self setHasObserver:YES];
        [self addObserver:self forKeyPath:@"_state" options:NSKeyValueObservingOptionNew context:nil];
    }
    
    NSMutableArray *attributes = [self attributes];
    if (!attributes) {
        [self setAttributes:[NSMutableArray array]];
    }
    
    if (attributes.count) {
        NSUInteger index = 0;
        UIButtonAttribute *tempAttribute = nil;
        
        for (UIButtonAttribute *att in attributes) {
            if (state == att.state.integerValue) {
                if (font) {
                    att.font = font;
                }
                if (backgroundColor) {
                    att.backgroundColor = backgroundColor;
                }
                index = [attributes indexOfObject:att];
                tempAttribute = att;
            }
        }
        if (tempAttribute) {
            [[self attributes] replaceObjectAtIndex:index withObject:tempAttribute];
        }else{
            tempAttribute = [UIButtonAttribute new];
            if (backgroundColor) {
                tempAttribute.backgroundColor = backgroundColor;
            }
            if (font) {
                tempAttribute.font = font;
            }
            tempAttribute.state = @(state);
            [[self attributes] addObject:tempAttribute];
        }
    }else{
        UIButtonAttribute *attribute = [UIButtonAttribute new];
        if (backgroundColor) {
            attribute.backgroundColor = backgroundColor;
        }
        if (font) {
            attribute.font = font;
        }
        attribute.state = @(state);
        [[self attributes] addObject:attribute];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSInteger currentState = [change[@"new"] integerValue];
    for (UIButtonAttribute *attribute in [self attributes]) {
        if (currentState == attribute.state.integerValue) {
            if (attribute.backgroundColor) {
                self.backgroundColor = attribute.backgroundColor;
            }
            if (attribute.font) {
                self.titleLabel.font = attribute.font;
            }
        }
    }
}

- (void)easy_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self easy_touchesEnded:touches withEvent:event];
    [self set_state:self.state];
}

- (void)easy_touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isNeedHighlighted) {
        [self easy_touchesMoved:touches withEvent:event];
    }else{
        [self easy_touchesEnded:touches withEvent:event];
    }
    [self set_state:self.state];
}

- (void)easy_removeFromSuperview{
    if ([self respondsToSelector:@selector(hasObserver)]) {
        if ([self hasObserver]) {
            [self setHasObserver:NO];
            [self removeObserver:self forKeyPath:@"_state"];
        }
        [self easy_removeFromSuperview];
    }
}

@end

