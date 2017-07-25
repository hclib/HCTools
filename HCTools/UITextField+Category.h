//
//  UITextField+Category.h
//  SpaceHome
//
//  Created by suhc on 2017/7/19.
//  Copyright © 2017年 David. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

/**
 *  限制字符提示(应用场景限制字符数据）
 *
 *  @param target   action的Target
 *  @param action   限制条件执行事件
 *  @param limitMax 内容宽度最大值
 */
- (void)addTarget:(id)target action:(SEL)action limitMax:(NSInteger)limitMax;

@end
