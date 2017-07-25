//
//  NSDictionary+Category.h
//  SpaceHome
//
//  Created by suhc on 2017/7/19.
//  Copyright © 2017年 David. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)

/**
 如果akey找不到，返回@"" (防止出现nil，使程序崩溃)

 @param aKey 字典key值
 @return 字典value
 */
- (NSString *)stringForKey:(id)aKey;

/**
 如果akey找不到，返回默认值 (防止出现nil，使程序崩溃)

 @param aKey 字典key值
 @param defValue 为空时的默认值
 @return 字典value
 */
- (NSString *)stringForKey:(id)aKey withDefaultValue:(NSString *)defValue;

/**
 替换&nbsp;为空

 @param aKey 字典key值
 @return 字典value
 */
- (NSString *)replaceNBSPforKey:(id)aKey;

@end
