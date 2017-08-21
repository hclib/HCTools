//
//  HCAlertView.m
//  SpaceHome
//
//  Created by suhc on 2017/8/14.
//  Copyright © 2017年 kongjianjia.com. All rights reserved.
//

#import "HCAlertView.h"

@implementation HCAlertView

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message options:(NSArray *)options colors:(NSArray *)colors callBacks:(NSArray<void (^)()> *)callBacks{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSUInteger count = options.count;
    for (int i = 0; i < count; i++) {
        NSString *option = options[i];
        if (option.length) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:option style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                if(callBacks[i]){
                    callBacks[i]();
                }
            }];
            if (colors[i]) {
                [alertAction setValue:colors[i] forKey:@"_titleTextColor"];
            }else{
                [alertAction setValue:[UIColor grayColor] forKey:@"_titleTextColor"];
            }
            [alertVC addAction:alertAction];
        }
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message options:(NSArray *)options callBacks:(NSArray<void (^)()> *)callBacks{
    [self alertWithTitle:title message:message options:options colors:nil callBacks:callBacks];
}

@end
