//
//  UIColor+Hex.m
//  funner
//
//  Created by suhc on 15/7/3.
//  Copyright (c) 2015年 ilinker. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

//  十六进制颜色转换为UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexString{
    
    NSString *colorString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    //  string should be 6 or 8 characters
    if ([colorString length] < 6) {
        return [UIColor clearColor];
    }
    
    //  strip 0X if it appears
    if ([colorString hasPrefix:@"0X"]) {
        colorString = [colorString substringFromIndex:2];
    }
    
    if ([colorString hasPrefix:@"#"]) {
        colorString = [colorString substringFromIndex:1];
    }
    
    if ([colorString length] != 6) {
        return [UIColor clearColor];
    }
    
    //  separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //  r
    NSString *rString = [colorString substringWithRange:range];
    
    //  g
    range.location = 2;
    NSString *gString = [colorString substringWithRange:range];
    
    //  b
    range.location = 4;
    NSString *bString = [colorString substringWithRange:range];
    
    //  scan value
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:1.0f];
}


@end
