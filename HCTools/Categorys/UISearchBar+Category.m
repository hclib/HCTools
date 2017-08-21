//
//  UISearchBar+Category.m
//  hclib
//
//  Created by hclib on 2017/8/21.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import "UISearchBar+Category.h"

@implementation UISearchBar (Category)

- (void)setTextColor:(UIColor *)textColor{
    [self _textField].textColor = textColor;
}

- (UIColor *)textColor{
    return [self _textField].textColor;
}

- (void)setPlaceholderColer:(UIColor *)placeholderColer{
    UITextField *textField = [self _textField];
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColer}];
    textField.attributedPlaceholder = attrM;
}

- (UIColor *)placeholderColer{
    UITextField *textField = [self _textField];
    NSAttributedString *attStr = textField.attributedPlaceholder;
    NSRange range = NSMakeRange(0, attStr.string.length);
    NSDictionary *attDic = [attStr attributesAtIndex:0 effectiveRange:&range];
    return (UIColor *)(attDic[NSForegroundColorAttributeName]);
}

- (void)setFont:(UIFont *)font{
    [self _textField].font = font;
}

- (UIFont *)font{
    return [self _textField].font;
}

- (void)setBgColor:(UIColor *)bgColor{
    self.barTintColor = bgColor;
    [self _textField].backgroundColor = bgColor;
}

- (UIColor *)bgColor{
    return [self _textField].backgroundColor;
}

- (void)setSearchIcon:(UIImage *)searchIcon state:(UIControlState)state{
    [self setImage:searchIcon forSearchBarIcon:UISearchBarIconSearch state:state];
}

- (UITextField *)_textField{
    UITextField *textField = nil;
    for (UIView *view in self.subviews) {
        for (UIView *subView in view.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                textField =  (UITextField *)subView;
                break;
            }
        }
    }
    return textField;
}

@end
