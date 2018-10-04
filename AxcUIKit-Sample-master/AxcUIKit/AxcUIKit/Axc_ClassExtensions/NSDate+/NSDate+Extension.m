//
//  NSDate+Extension.m
//  CreateChater
//
//  Created by CoDancer on 2016/12/21.
//  Copyright © 2016年 Fm. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isThisYear:(NSString *)timeStr
{
    // 日历
    NSDateComponents *comp = [self currentTime];
    NSArray *subDataArr = [timeStr componentsSeparatedByString:@"-"];
    NSString *monthStr = [subDataArr objectAtIndex:0];
    if (comp.year == [monthStr integerValue]) {
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday
{
    // 2014-12-31 23:59:59 -> 2014-12-31
    // 2015-01-01 00:00:01 -> 2015-01-01
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}


//判断是不是本星期
- (BOOL)isThisWeak{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear | kCFCalendarUnitDay | kCFCalendarUnitHour | kCFCalendarUnitMinute ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *sourceCmps = [calendar components:unit fromDate:self];
    
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:[NSDate date] toDate:self options:0];
    NSInteger subDay = labs(dateCom.day);
    NSInteger subMonth = labs(dateCom.month);
    NSInteger subYear = labs(dateCom.year);
    
    if (subYear == 0 && subMonth == 0) { //当相关的差值等于零的时候说明在一个年、月、日的时间范围内，不是按照零点到零点的时间算的
        if (subDay > 6) { //相差天数大于6肯定不在一周内
            return NO;
        } else { //相差的天数大于或等于后面的时间所对应的weekday则不在一周内
            if (dateCom.day >= 0 && dateCom.hour >=0 && dateCom.minute >= 0) { //比较的时间大于当前时间
                //西方一周的开始是从周日开始算的，周日是1，周一是2，而我们是从周一开始算新的一周
                NSInteger chinaWeekday = sourceCmps.weekday == 1 ? 7 : sourceCmps.weekday - 1;
                if (subDay >= chinaWeekday) {
                    return NO;
                } else {
                    return YES;
                }
            } else {
                NSInteger chinaWeekday = sourceCmps.weekday == 1 ? 7 : nowCmps.weekday - 1;
                if (subDay >= chinaWeekday) { //比较的时间比当前时间小，已经过去的时间
                    return NO;
                } else {
                    return YES;
                }
            }
        }
    } else { //时间范围差值超过了一年或一个月的时间范围肯定就不在一个周内了
        return NO;
    }
}


- (NSDateComponents *)currentTime {
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate* dt = [NSDate date];
    
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    
    return comp;
}

//是否凌晨比较使用
- (NSDateComponents *)dateComponets
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:self];
    return comp;
}

- (NSString *)currentTimeStr {
    
    NSDateComponents *comp = [self currentTime];
    NSString *monthStr = @"";
    NSString *dayStr = @"";
    NSString *hourStr = @"";
    NSString *minuteStr = @"";
    if (comp.month < 10) {
        monthStr = [NSString stringWithFormat:@"0%ld",comp.month];
    }
    if (comp.month < 10) {
        dayStr = [NSString stringWithFormat:@"0%ld",comp.day];
    }
    if (comp.month < 10) {
        hourStr = [NSString stringWithFormat:@"0%ld",comp.hour];
    }
    if (comp.month < 10) {
        minuteStr = [NSString stringWithFormat:@"0%ld",comp.minute];
    }
    NSString *currentStr = [NSString stringWithFormat:@"%ld-%@-%@ %@:%@",
                            comp.year,monthStr,dayStr,hourStr,monthStr
                            ];
    return currentStr;
}

-(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date]; //现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}

- (BOOL) isSameMonthAsDate:(NSString *)timeStr {
    
    NSDateComponents *comp = [self currentTime];
    NSArray *subDataArr = [timeStr componentsSeparatedByString:@"-"];
    NSString *monthStr = [subDataArr objectAtIndex:1];
    if (comp.month == [monthStr integerValue]) {
        return YES;
    }else {
        return NO;
    }
}

/**
 *  判断是不是本月
 *
 *  @return YES 是 NO 不是
 */
- (BOOL)isThisMonth:(NSString *)timeStr {
    
    return [self isSameMonthAsDate:timeStr];
}

+ (NSCalendar *) currentCalendar {
    
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar) {
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    }
    return sharedCalendar;
}

- (NSString *)weekdayStringWithDate:(NSDate *)date {
    //获取星期几
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekday fromDate:date];
    NSInteger weekday = [componets weekday];//1代表星期日，2代表星期一，后面依次
    NSArray *weekArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *weekStr = weekArray[weekday-1];
    return weekStr;
}


@end

