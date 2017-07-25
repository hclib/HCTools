//
//  NSDictionary+Category.m
//  SpaceHome
//
//  Created by suhc on 2017/7/19.
//  Copyright © 2017年 David. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

- (NSString*) stringForKey:(id)aKey {
    return [self stringForKey:aKey withDefaultValue:@""];
}

- (NSString *)stringForKey:(id)aKey withDefaultValue:(NSString *)defValue {
    NSString *value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]])
    {
        value = defValue;
    }
    return [NSString stringWithFormat:@"%@",value];
}

- (NSString*)replaceNBSPforKey:(id)aKey {
    NSString *value = [self objectForKey:aKey];
    if (!value)
    {
        value = @"";
    }
    
    NSString* str = [value stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "] ;
    
    return [NSString stringWithFormat:@"%@",str];
}

@end
