//
//  CustomButton.m
//  test
//
//  Created by hclib on 2017/8/7.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import "HCCustomButton.h"

@interface HCCustomButton ()
{
    CGFloat _titleW;
    CGFloat _titleH;
    CGFloat _imageW;
    CGFloat _imageH;
}
@end

@implementation HCCustomButton

+ (instancetype)customButtonWithType:(HCCustomButtonType)type{
    return [[HCCustomButton alloc] initWithType:type];
}

- (instancetype)initWithType:(HCCustomButtonType)type{
    if (self = [super init]) {
        self.type = type;
        [self.titleLabel addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
        self.imageView.contentMode = UIViewContentModeCenter;
        if (type == HCCustomButtonTypeDefault) {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        } if (type == HCCustomButtonTypeImageOnRight) {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }else{
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    _titleW = [self titleWidth];
    _titleH = [self titleHeight];
    
    [self titleRectForContentRect:CGRectZero];
    [self imageRectForContentRect:CGRectZero];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
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
        return CGRectMake(_imageW + _padding, (height - _titleH) * 0.5, _titleW, _titleH);
    }else if (self.type == HCCustomButtonTypeImageOnRight) {
        return CGRectMake(width - _imageW - _padding - _titleW, (height - _titleH) * 0.5, _titleW, _titleH);
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
        return CGRectMake(0, (height - _imageH) * 0.5, _imageW, _imageH);
    }else if (self.type == HCCustomButtonTypeImageOnRight) {
        return CGRectMake(width - _imageW, (height - _titleH) * 0.5, _imageW, _imageH);
    }else if (self.type == HCCustomButtonTypeImageOnTop) {
        return CGRectMake((width - _imageW) * 0.5, y, _imageW, _imageH);
    }else if (self.type == HCCustomButtonTypeImageOnBottom) {
        return CGRectMake((width - _imageW) * 0.5, y + _titleH + _padding, _imageW, _imageH);
    }else{
        return CGRectZero;
    }
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

- (void)dealloc{
    [self.titleLabel removeObserver:self forKeyPath:@"font"];
    NSLog(@"%@---dealloc",NSStringFromClass(self.class));
}

@end
