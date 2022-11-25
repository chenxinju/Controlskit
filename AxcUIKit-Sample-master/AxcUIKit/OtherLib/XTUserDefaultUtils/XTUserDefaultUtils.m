//
//  XTUserDefaultUtils.m
//  XTUtils
//
//  Created by 何凯楠 on 2017/4/17.
//  Copyright © 2017年 HeXiaoBa. All rights reserved.
//

#import "XTUserDefaultUtils.h"

@implementation XTUserDefaultUtils
/**
 为值设置一个key，保存起来
 */
+ (BOOL)xt_setObject:(id)object forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
    return [userDefaults synchronize];
}

/**
 通过key获取保存的值
 */
+ (id)xt_objectForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

/**
 通过key删除值
 */
+ (void)xt_removeObjectForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults removeObjectForKey:key];
}

/**
 通过key获取一个string类型的值
 */
- (NSString *)xt_stringForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:key];
}

/**
 通过key获取一个array类型的值
 */
- (NSArray *)xt_arrayForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults arrayForKey:key];
}

/**
 通过key获取一个NSDictionary类型的值

 @param key key
 @return NSDictionary类型的值
 */
- (NSDictionary<NSString *, id> *)xt_dictionaryForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dictionaryForKey:key];
}

/**
 通过key获取一个NSData类型的值

 @param key key
 @return NSData类型的值
 */
- (NSData *)xt_dataForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults dataForKey:key];
}

/**
 通过key获取一个NSArray类型的值
 
 @param key key
 @return NSArray类型的值
 */
- (NSArray<NSString *> *)xt_stringArrayForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringArrayForKey:key];
}

/**
 通过key获取一个NSInteger类型的值
 
 @param key key
 @return NSInteger类型的值
 */
- (NSInteger)xt_integerForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults integerForKey:key];
}

/**
 通过key获取一个float类型的值
 
 @param key key
 @return float类型的值
 */
- (float)xt_floatForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults floatForKey:key];
}

/**
 通过key获取一个double类型的值
 
 @param key key
 @return double类型的值
 */
- (double)xt_doubleForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults doubleForKey:key];
}

/**
 通过key获取一个BOOL类型的值
 
 @param key key
 @return BOOL类型的值
 */
- (BOOL)xt_boolForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}

/**
 通过key获取一个NSURL类型的值
 
 @param key key
 @return NSURL类型的值
 */
- (NSURL *)xt_URLForKey:(NSString *)key NS_AVAILABLE(10_6, 4_0) {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults URLForKey:key];
}

/**
 保存一个NSInteger类型的值

 @param value NSInteger类型的值
 @param key key
 */
- (void)xt_setInteger:(NSInteger)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
    [userDefaults synchronize];
}

/**
 保存一个float类型的值
 
 @param value float类型的值
 @param key key
 */
- (void)xt_setFloat:(float)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:value forKey:key];
    [userDefaults synchronize];
}

/**
 保存一个double类型的值
 
 @param value double类型的值
 @param key key
 */
- (void)xt_setDouble:(double)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:value forKey:key];
    [userDefaults synchronize];
}

/**
 保存一个BOOL类型的值
 
 @param value BOOL类型的值
 @param key key
 */
- (void)xt_setBool:(BOOL)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

/**
 保存一个NSURL类型的值
 
 @param url NSURL类型的值
 @param key key
 */
- (void)xt_setURL:(NSURL *)url forKey:(NSString *)key NS_AVAILABLE(10_6, 4_0) {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setURL:url forKey:key];
    [userDefaults synchronize];
}



@end
