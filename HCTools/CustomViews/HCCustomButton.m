//
//  CustomButton.m
//  test
//
//  Created by hclib on 2017/8/7.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import "HCCustomButton.h"

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

static NSString *keyPath_State = @"currentState";
#pragma mark - CustomButton
@interface HCCustomButton ()
{
    CGFloat _titleW;
    CGFloat _titleH;
    CGFloat _imageW;
    CGFloat _imageH;
}
/**当前的状态*/
@property (nonatomic, assign) UIControlState currentState;
/**是否有观察者*/
@property (nonatomic, assign, getter=isHasObserver) BOOL hasObserver;
/**属性数组*/
@property (nonatomic, strong) NSMutableArray<UIButtonAttribute *> *attributes;
@end

@implementation HCCustomButton

+ (instancetype)customButtonWithType:(HCCustomButtonType)type{
    return [[HCCustomButton alloc] initWithType:type];
}

+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    NSAssert(NO, @"please use customButtonWithType: to initialize");
    return [super buttonWithType:buttonType];
}

- (instancetype)init{
    NSAssert(NO, @"please use customButtonWithType: to initialize");
    return [super init];
}

- (instancetype)initWithType:(HCCustomButtonType)type{
    if (self = [super init]) {
        self.type = type;
        [self.titleLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.backgroundColor = [UIColor clearColor];
        
        //默认不需要高亮状态
        self.needHighlighted = NO;
    }
    return self;
}

- (void)setNeedHighlighted:(BOOL)needHighlighted{
    if (_needHighlighted == needHighlighted) {
        return;
    }
    _needHighlighted = needHighlighted;
    self.adjustsImageWhenHighlighted = _needHighlighted;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:keyPath_State]) {
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
    }else{
        _titleW = [self titleWidth];
        _titleH = [self titleHeight];
        
        [self titleRectForContentRect:CGRectZero];
        [self imageRectForContentRect:CGRectZero];
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    if ([title isEqualToString:self.titleLabel.text]) {
        return;
    }
    [super setTitle:title forState:state];
    _titleW = [self titleWidth];
    _titleH = [self titleHeight];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    _imageW = [self imageWidth];
    _imageH = [self imageHeight];
}

- (void)setPadding:(CGFloat)padding{
    _padding = padding;
    [self titleRectForContentRect:CGRectZero];
    [self imageRectForContentRect:CGRectZero];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat y = (height - _titleH - _padding - _imageH) * 0.5;
        
    if (self.type == HCCustomButtonTypeDefault) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            return CGRectMake(_imageW + _padding, (height - _titleH) * 0.5, _titleW, _titleH);
        }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            return CGRectMake(width - _titleW, (height - _titleH) * 0.5, _titleW, _titleH);
        }else{
            CGFloat x = (width - _imageW - _padding - _titleW) * 0.5 + _imageW + _padding;
            return CGRectMake(x, (height - _titleH) * 0.5, _titleW, _titleH);
        }
        
    }else if (self.type == HCCustomButtonTypeImageOnRight) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            return CGRectMake(0, (height - _titleH) * 0.5, _titleW, _titleH);
        }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            return CGRectMake(width - _imageW - _padding - _titleW, (height - _titleH) * 0.5, _titleW, _titleH);
        }else{
            return CGRectMake((width - _imageW - _padding - _titleW) * 0.5, (height - _titleH) * 0.5, _titleW, _titleH);
        }
    }else if(self.type == HCCustomButtonTypeImageOnTop){
        return CGRectMake((width - _titleW) * 0.5, y + _imageH + _padding, _titleW, _titleH);
    }else if(self.type == HCCustomButtonTypeImageOnBottom){
        return CGRectMake((width - _titleW) * 0.5, y, _titleW, _titleH);
    }else{
        return CGRectZero;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat y = (height - _titleH - _padding - _imageH) * 0.5;
    if (self.type == HCCustomButtonTypeDefault) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            return CGRectMake(0, (height - _imageH) * 0.5, _imageW, _imageH);
        }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            return CGRectMake(width - _titleW - _padding - _imageW, (height - _imageH) * 0.5, _imageW, _imageH);
        }else{
            CGFloat x = (width - _imageW - _padding - _titleW) * 0.5;
            return CGRectMake(x, (height - _imageH) * 0.5, _imageW, _imageH);
        }
    }else if (self.type == HCCustomButtonTypeImageOnRight) {
        if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
            return CGRectMake(_titleW + _padding, (height - _imageH) * 0.5, _imageW, _imageH);
        }else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
            return CGRectMake(width - _imageW, (height - _imageH) * 0.5, _imageW, _imageH);
        }else{
            CGFloat x = (width - _imageW - _padding - _titleW) * 0.5;
            return CGRectMake(x + _titleW + _padding, (height - _imageH) * 0.5, _imageW, _imageH);
        }
    }else if (self.type == HCCustomButtonTypeImageOnTop) {
        return CGRectMake((width - _imageW) * 0.5, y, _imageW, _imageH);
    }else if (self.type == HCCustomButtonTypeImageOnBottom) {
        return CGRectMake((width - _imageW) * 0.5, y + _titleH + _padding, _imageW, _imageH);
    }else{
        return CGRectZero;
    }
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment{
    [super setContentHorizontalAlignment:contentHorizontalAlignment];
    
    [self titleRectForContentRect:CGRectZero];
    [self imageRectForContentRect:CGRectZero];
}

#pragma mark - 计算尺寸
- (CGFloat)titleWidth{
    return [self widthForText:self.titleLabel.text font:self.titleLabel.font];
}

- (CGFloat)titleHeight{
    return [self heightForText:self.titleLabel.text font:self.titleLabel.font width:[self titleWidth]];
}

- (CGFloat)imageWidth{
    return self.imageView.image.size.width;
}

- (CGFloat)imageHeight{
    return self.imageView.image.size.height;
}

- (CGFloat)widthForText:(NSString *)text font:(UIFont *)font {
    CGSize size = [self sizeForText:text font:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForText:text font:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (CGSize)sizeForText:(NSString *)text font:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [text boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [text sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

#pragma mark - 处理不同状态下的背景颜色和字体大小
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
    if (!self.isHasObserver) {
        self.hasObserver = YES;
        [self addObserver:self forKeyPath:keyPath_State options:NSKeyValueObservingOptionNew context:nil];
    }
    
    NSUInteger count = self.attributes.count;
    
    if (count) {
        NSUInteger index = 0;
        UIButtonAttribute *tempAttribute = nil;
        
        for (UIButtonAttribute *attribute in self.attributes) {
            if (state == attribute.state.integerValue) {
                if (font) {
                    attribute.font = font;
                }
                if (backgroundColor) {
                    attribute.backgroundColor = backgroundColor;
                }
                index = [self.attributes indexOfObject:attribute];
                tempAttribute = attribute;
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
            [self.attributes addObject:tempAttribute];
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
        [self.attributes addObject:attribute];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.isNeedHighlighted) {
        [super touchesMoved:touches withEvent:event];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
    self.currentState = self.state;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    self.currentState = self.state;
}

#pragma mark - 懒加载
- (NSMutableArray *)attributes{
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

- (void)dealloc{
    [self.titleLabel removeObserver:self forKeyPath:@"font"];
    if (self.isHasObserver) {
        [self removeObserver:self forKeyPath:keyPath_State];
    }
}

@end
