//
//  HCAttributeLabel.h
//  HCAttributeLabel
//
//  Created by hclib on 2017/8/3.
//  Copyright © 2017年 hclib. All rights reserved.
//

/**
 方便的实现富文本效果，把需要高亮显示的文字用<>包括起来，需要显示的图片用[]包括起来，如果需要显示<>或者[]，则在前面加上\\进行转义即可
 例如：    @"中华人民共和国<万岁>![love.png]<中华>!\\[我们\\]都是\\<炎黄子孙\\>
 输出效果是： 中华人民共和国万岁!❤️我中华![我们]都是<炎黄子孙>
 其中“万岁”和"中华"是高亮显示，并且可以点击(在实现回调block的前提下)
 */
#import <UIKit/UIKit.h>

/**富文本插件*/
@interface HCAttributeLabel : UITextView

/**高亮文字字体大小，默认和普通文本字体大小一致*/
@property (nonatomic, strong) UIFont *highlightFont;

/**高亮文字字体颜色，默认和普通文本颜色相同*/
@property (nonatomic, strong) UIColor *highlightColor;

/**高亮文字点击回调*/
@property (nonatomic, copy) void(^HighlightAction)(NSString *highlightText);

/**文字之间的垂直间距*/
@property (nonatomic, assign) CGFloat lineSpacing;

/**首行缩进*/
@property (nonatomic, assign) CGFloat firstLineHeadIndent;

/**段落之间的间距*/
@property (nonatomic, assign) CGFloat paragraphSpacing;

@end

