//
//  FMGlobal.h
//  JobProject
//
//  Created by CoDancer on 16/12/14.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FMGlobal : NSObject

//获取解密数据
+ (NSDictionary *)getRealDicOf:(NSString *)str;



/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 */
+ (NSString *)encryptString:(NSString *)str;


/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 */
+ (NSString *)decryptString:(NSString *)str;
@end
