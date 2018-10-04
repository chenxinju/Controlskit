//
//  NSString+Extension.h
//  Screenshot
//
//  Created by CoDancer on 2016/12/21.
//  Copyright © 2016年 Fm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)create_time:(NSString *)timeStr;

- (NSString *)wxHomeFriednCreate_time:(NSString *)timeStr;

- (NSString *)alipayCreate_time:(NSString *)timeStr;
//支付收发红包
- (NSString *)alipayCreate_Redsecond_time:(NSString *)timeStr;

//账单选择使用
- (NSString *)alipayCreatAlipyBilltime:(NSString *)timeStr;
//聊天列表使用
- (NSString *)addTime:(NSString *)timeStr;

//获取当前时间 上午或下午区分
+(NSString *)getCurrentTimeWithformat:(NSString *)formatStr;
/* 获取当前年-月-日 时分秒**/
+ (NSString *)getTheCurrentTimeisdividedIntoeconds;

- (NSString *)randomNumStrWithNum:(NSInteger)num;

/**
 *  获取未来某个日期是星期几
 *  注意：featureDate 传递过来的格式 必须 和 formatter.dateFormat 一致，否则endDate可能为nil
 *
 */

- (NSString *)featureWeekdayWithDate:(NSString *)featureDate;

/**
 *  计算2个日期相差天数
 *  startDate   起始日期
 *  endDate     截至日期
 */
-(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate;


/**
 *  根据日期计算星期几
 */
- (NSString*)weekDayStr:(NSString *)format;


+ (NSString *)getCurrtnTimeSp;


- (NSString *)MD5HashString;

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString;


- (NSString *)aboutMonth;


/**
 金额显示逗号分隔
 
 @param string 需要处理的金额
 @return 转换后的
 */
+(NSString *)strmethodComma:(NSString *)string;



@end
