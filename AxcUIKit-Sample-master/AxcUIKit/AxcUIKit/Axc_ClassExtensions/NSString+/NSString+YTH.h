//
//  NSString+YTH.h
//  Screenshot1
//
//  Created by Chenxinju on 2018/5/3.
//  Copyright © 2018年 Fm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YTH)

/**
 未知类型（仅限字典/数组/字符串）
 
 @param object 字典/数组/字符串
 @return 字符串
 */
+(NSString *) jsonStringWithObject:(id) object;

/**
 字典类型转JSON
 
 @param dictionary 字典数据
 @return 返回字符串
 */
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;


/**
 数组类型转JSON
 
 @param array 数组类型
 @return 返回字符串
 */
+(NSString *)jsonStringWithArray:(NSArray *)array;


/**
 字符串类型转JSON
 
 @param string 字符串类型
 @return 返回字符串
 */
+(NSString *) jsonStringWithString:(NSString *) string;



@end
