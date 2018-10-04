//
//  NSDate+Extension.h
//  CreateChater
//
//  Created by CoDancer on 2016/12/21.
//  Copyright © 2016年 Fm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

- (BOOL)isThisYear:(NSString *)timeStr;

- (BOOL)isThisMonth:(NSString *)timeStr;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

/**
 * 判断是不是本星期
 */
- (BOOL)isThisWeak;

- (NSDateComponents *)currentTime;

//比较凌晨
- (NSDateComponents *)dateComponets;


- (NSString *)currentTimeStr;

@end

