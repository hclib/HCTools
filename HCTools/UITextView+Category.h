//
//  UITextView+Category.h
//  SpaceHome
//
//  Created by suhc on 2017/7/18.
//  Copyright © 2017年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Category)

/**
 *  限制字符提示(应用场景限制字符数据）
 *
 *  @param target   action的Target
 *  @param action   限制条件执行事件
 *  @param limitMax 内容宽度最大值
 */
- (void)addTarget:(id)target action:(SEL)action limitMax:(NSInteger)limitMax;

/**default is nil. string is drawn 70% gray*/
@property (nonatomic, copy) NSString *placeholder;

@end
