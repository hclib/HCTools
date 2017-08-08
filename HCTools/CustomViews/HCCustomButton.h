//
//  CustomButton.h
//  test
//
//  Created by hclib on 2017/8/7.
//  Copyright © 2017年 hclib. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HCCustomButtonTypeImageOnRight = 0,   //文字在左，图片在右边
    HCCustomButtonTypeImageOnTop,         //文字在下面，图片在上面
    HCCustomButtonTypeImageOnBottom,      //文字在上面，图片在下面
} HCCustomButtonType;

@interface HCCustomButton : UIButton

/**按钮类型*/
@property (nonatomic, assign) HCCustomButtonType type;

/**图片和文字之间的间隔*/
@property (nonatomic, assign) CGFloat padding;

+ (instancetype)customButtonWithType:(HCCustomButtonType)type;

@end
