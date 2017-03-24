
#ifndef Singleton_h
#define Singleton_h

/**
 * 快速创建单例
 */

// 接口定义
#define singletonInterface(className)          + (instancetype)shared##className;

// 实现定义
// 在定义宏时 \ 可以用来拼接字符串
#define singletonImplementation(className) \
static className *_instance; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
+ (instancetype)shared##className \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
    return _instance; \
}

// 提示:最末尾不要使用反斜线


#endif
