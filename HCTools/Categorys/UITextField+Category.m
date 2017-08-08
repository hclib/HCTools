//
//  UITextField+Category.m
//  SpaceHome
//
//  Created by suhc on 2017/7/19.
//  Copyright © 2017年 David. All rights reserved.
//

#import "UITextField+Category.h"
#import <objc/runtime.h>

static char *kAction;
static char *kLimit;
static char *kTargetKey;

@implementation UITextField (Category)

/**
 *  限制字符提示
 *
 *  @param target   action的Target
 *  @param action   限制执行事件
 *  @param limitMax 限制数量
 */
- (void)addTarget:(id)target action:(SEL)action limitMax:(NSInteger)limitMax{
    
    NSString *limitStr = [NSString stringWithFormat:@"%zd",limitMax];
    objc_setAssociatedObject(self, &kLimit, limitStr, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &kTargetKey, target, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, &kAction, NSStringFromSelector(action), OBJC_ASSOCIATION_COPY);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange) name: UITextViewTextDidChangeNotification object:nil];
}

/**
 *  输入内容限制
 */
- (void)textViewTextDidChange{
    
    id target = objc_getAssociatedObject(self, &kTargetKey);
    if (!target && ![target isKindOfClass:[NSNull class]]) {
        return;
    }
    NSString *actionStr = objc_getAssociatedObject(self, &kAction);
    SEL runAction = NSSelectorFromString(actionStr);
    if (!runAction) {
        return;
    }
    
    NSString *limitStr = objc_getAssociatedObject(self, &kLimit);
    NSInteger maxLength = [limitStr integerValue];
    
    NSString *toBeString = self.text;
    NSString *lang = self.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = self.markedTextRange;
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxLength) {
                
                self.text = [self.text substringToIndex:maxLength];
                
                if ([target respondsToSelector:runAction]) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"  //消除performSelector 可能不存在的警告
                    [target performSelector:runAction ];
                }
            }else{
                //有高亮选择的字符串，则暂不对文字进行统计和限制
                
            }
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > maxLength){
            //找到当前输入光标位置, 删除超出内容
            self.text = [self.text substringToIndex:maxLength];
            
            if ([target respondsToSelector:runAction]) {
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"  //消除performSelector 可能不存在的警告
                [target performSelector:runAction ];
            }
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

@end
