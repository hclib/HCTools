//
//  HCAlertView.h
//  SpaceHome
//
//  Created by suhc on 2017/8/14.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCAlertView : UIView

/**
 快速创建一个使用系统默认颜色选项的AlertView
 
 @param title 标题
 @param description 描述
 @param option1 选项一
 @param callBack1 选项一的回调方法
 @param option2 选项二
 @param callBack2 选项二的回调
 @param option3 选项三
 @param callBack3 选项三的回调
 @return 创建好的AlertView
 */
#define K_ALERT_VIEW(title, description, option1, callBack1, option2, callBack2, option3, callBack3)  \
K_ALERT_COLOR_VIEW(title, description, option1, nil, callBack1, option2, nil, callBack2, option3, nil, callBack3)


/**
 快速创建一个自定义选项颜色的AlertView
 
 @param title 标题
 @param description 描述
 @param option1 选项一
 @param color1 选项一的文字颜色
 @param callBack1 选项一的回调
 @param option2 选项二
 @param color2 选项二的文字颜色
 @param callBack2 选项二的回调
 @param option3 选项三
 @param color3 选项三的文字颜色
 @param callBack3 选项三的回调
 @return 创建好的AlertView
 */
#define K_ALERT_COLOR_VIEW(title, description, option1, color1, callBack1, option2, color2, callBack2, option3, color3, callBack3) \
[HCAlertView alertWithTitle:title message:description options:@[option1 ? option1 : @"",option2 ? option2 : @"",option3 ? option3 : @""] colors:@[color1 ? color1 : [UIColor grayColor], color2 ? color2 : [UIColor grayColor], color3 ? color3 : [UIColor grayColor]] callBacks:@[callBack1 ? callBack1 : ^{},callBack2 ? callBack2 : ^{},callBack3 ? callBack3 : ^{}]];

/**
 快速创建AlertView(各个选项的颜色默认是grayColor)

 @param title 标题
 @param message 提示信息
 @param options 选项数组
 @param callBacks 回调数组
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message options:(NSArray *)options callBacks:(NSArray<void(^)()> *)callBacks;

/**
 快速创建AlertView

 @param title 标题
 @param message 提示信息
 @param options 选项数组
 @param colors 各选项文字颜色数组
 @param callBacks 回调数组
 */
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message options:(NSArray *)options colors:(NSArray *)colors callBacks:(NSArray<void(^)()> *)callBacks;

@end
