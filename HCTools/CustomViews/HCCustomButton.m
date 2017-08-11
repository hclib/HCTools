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
    CGFloat _maxWidth;
    CGFloat _maxHeight;
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
        } if (type == UIControlContentHorizontalAlignmentRight) {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }else{
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    _titleW = [self titleWidth];
    _maxWidth = [self maxWidth];
    _titleH = [self titleHeight];
    _maxHeight = [self maxHeight];
    
    [self layoutSubviews];
    [self titleRectForContentRect:CGRectZero];
    [self imageRectForContentRect:CGRectZero];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    _titleW = [self titleWidth];
    _maxWidth = [self maxWidth];
    _titleH = [self titleHeight];
    _maxHeight = [self maxHeight];
    [self layoutSubviews];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    _imageW = [self imageWidth];
    _imageH = [self imageHeight];
    _maxWidth = [self maxWidth];
    _maxHeight = [self maxHeight];
    [self layoutSubviews];
}

- (void)setPadding:(CGFloat)padding{
    _padding = padding;
    _maxWidth = [self maxWidth];
    _maxHeight = [self maxHeight];
    
    [self layoutSubviews];
    [self titleRectForContentRect:CGRectZero];
    [self imageRectForContentRect:CGRectZero];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _maxWidth = frame.size.width;
    _maxHeight = frame.size.height;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect tempFrame = self.frame;
    if (self.type == HCCustomButtonTypeDefault || self.type == HCCustomButtonTypeImageOnRight) {
        if (_imageW < 0.01) {
            //没有图片
            tempFrame.size.width = _titleW;
        }else{
            tempFrame.size.width = _titleW + _padding + _imageW;
        }
        tempFrame.size.height = _maxHeight;
    }else{
        tempFrame.size.width = _maxWidth;
        tempFrame.size.height = _titleH + _padding + _imageH;
    }
    self.frame = tempFrame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (self.type == HCCustomButtonTypeDefault) {
        CGFloat padding = _imageW < 0.01 ? 0 : _padding;
        return CGRectMake(_imageW + padding, 0, _titleW, _maxHeight);
    }else if (self.type == HCCustomButtonTypeImageOnRight) {
        CGFloat padding = _imageW < 0.01 ? 0 : _padding;
        return CGRectMake(_maxWidth - _imageW - padding - _titleW, 0, _titleW, _maxHeight);
    }else if(self.type == HCCustomButtonTypeImageOnTop){
        return CGRectMake(0, _imageH + _padding, _maxWidth, _titleH);
    }else if(self.type == HCCustomButtonTypeImageOnBottom){
        return CGRectMake(0, 0, _maxWidth, _titleH);
    }else{
        return CGRectZero;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.type == HCCustomButtonTypeDefault) {
        return CGRectMake(0, 0, _imageW, _maxHeight);
    }else if (self.type == HCCustomButtonTypeImageOnRight) {
        return CGRectMake(_maxWidth - _imageW, 0, _imageW, _maxHeight);
    }else if (self.type == HCCustomButtonTypeImageOnTop) {
        return CGRectMake(0, 0, _maxWidth, _imageH);
    }else if (self.type == HCCustomButtonTypeImageOnBottom) {
        return CGRectMake(0, _titleH + _padding, _maxWidth, _imageH);
    }else{
        return CGRectZero;
    }
}

#pragma mark - 计算尺寸
- (CGFloat)maxWidth{
    CGFloat width = MAX(_imageW, _titleW);
    CGFloat maxWidth = MAX(self.frame.size.width, width);
    
    return maxWidth;
}

- (CGFloat)maxHeight{
    CGFloat height = MAX(_titleH, _imageH);
    CGFloat maxHeight = MAX(self.frame.size.height, height);
    
    return maxHeight;
}

- (CGFloat)titleWidth{
    return [self widthForText:self.titleLabel.text font:self.titleLabel.font];
}

- (CGFloat)titleHeight{
    return [self heightForText:self.titleLabel.text font:self.titleLabel.font width:_maxWidth];
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
