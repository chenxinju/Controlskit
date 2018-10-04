//
//  NSString+Extension.m
//  Screenshot
//
//  Created by CoDancer on 2016/12/21.
//  Copyright © 2016年 Fm. All rights reserved.
//

#import "NSString+Extension.h"
#import "NSDate+Extension.h"
#import "NSDataAdditions.h"

@implementation NSString (Extension)

//weiChat Time Type
- (NSString *)create_time:(NSString *)timeStr {
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    // [yyyy-mm-dd] [hh:mm]
    NSArray *dateArr = [timeStr componentsSeparatedByString:@" "];
    //[yyyy,mm,dd]
    NSArray *preDateArr = [[dateArr firstObject] componentsSeparatedByString:@"-"];
    
    NSString *numMonthStr = [NSString stringWithFormat:@"%@",preDateArr[1]];;
    NSString *numDayStr = [NSString stringWithFormat:@"%@",preDateArr[2]];
    if ([numMonthStr hasPrefix:@"0"]) {
        numMonthStr = [numMonthStr substringFromIndex:numMonthStr.length - 1];
    }
    if ([numDayStr hasPrefix:@"0"]) {
        numDayStr = [numDayStr substringFromIndex:numDayStr.length - 1];
    }
    NSString *preDateStr;
    NSString *dateStr;
    if (preDateArr.count == 3) {
        preDateStr = [NSString stringWithFormat:@"%@年%@月%@日 %@",
                      preDateArr[0],numMonthStr,numDayStr,
                      [dateArr lastObject]];
        dateStr = [NSString stringWithFormat:@"%@月%@日 %@",
                   numMonthStr,numDayStr,[dateArr lastObject]];
    }
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:timeStr];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        } else { // 其他
            
            return preDateStr;
        }
    } else { // 非今年
        return preDateStr;
    }
}

-(NSString *)wxHomeFriednCreate_time:(NSString *)timeStr
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    // [yyyy-mm-dd] [hh:mm]
    NSArray *dateArr = [timeStr componentsSeparatedByString:@" "];
    //[yyyy,mm,dd]
    NSArray *preDateArr = [[dateArr firstObject] componentsSeparatedByString:@"-"];
    
    NSString *numMonthStr = [NSString stringWithFormat:@"%@",preDateArr[1]];;
    NSString *numDayStr = [NSString stringWithFormat:@"%@",preDateArr[2]];
    if ([numMonthStr hasPrefix:@"0"]) {
        numMonthStr = [numMonthStr substringFromIndex:numMonthStr.length - 1];
    }
    if ([numDayStr hasPrefix:@"0"]) {
        numDayStr = [numDayStr substringFromIndex:numDayStr.length - 1];
    }
    NSString *preDateStr;
    NSString *dateStr;
    if (preDateArr.count == 3) {
        preDateStr = [NSString stringWithFormat:@"%@年%@月%@日 %@",
                      preDateArr[0],numMonthStr,numDayStr,
                      [dateArr lastObject]];
        dateStr = [NSString stringWithFormat:@"%@月%@日 %@",
                   numMonthStr,numDayStr,[dateArr lastObject]];
    }
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:timeStr];
    
    if (create.isThisYear) { // 今年
        NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
        if (create.isToday) { // 今天
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天";
            return [fmt stringFromDate:create];
        } else  if(cmps.day > 1){ // 其他
            return [NSString stringWithFormat:@"%zd天前", cmps.day];
        }else{
            return dateStr;
        }
    } else { // 非今年
        return preDateStr;
    }
}

////weiChat Time Type
- (NSString *)alipayCreate_time:(NSString *)timeStr {
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    // [yyyy-mm-dd] [hh:mm]
    NSArray *dateArr = [timeStr componentsSeparatedByString:@" "];
    //[yyyy,mm,dd]
    NSArray *preDateArr = [[dateArr firstObject] componentsSeparatedByString:@"-"];
    NSString *preDateStr;
    NSString *dateStr;
    if (preDateArr.count == 3) {
        preDateStr = [NSString stringWithFormat:@"%@-%@-%@",
                      preDateArr[0],preDateArr[1],preDateArr[2]];
        dateStr = [NSString stringWithFormat:@"%@-%@",
                   preDateArr[1],preDateArr[2]];
    }
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:timeStr];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            fmt.dateFormat = @"今天 HH:mm";
            return [fmt stringFromDate:create];
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return preDateStr;
    }
}

//支付宝收发红包
- (NSString *)alipayCreate_Redsecond_time:(NSString *)timeStr {
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // [yyyy-mm-dd] [hh:mm]
    NSArray *dateArr = [timeStr componentsSeparatedByString:@" "];
    //[yyyy,mm,dd]
    NSArray *preDateArr = [[dateArr firstObject] componentsSeparatedByString:@"-"];
    NSString *preDateStr;
    NSString *dateStr;
    if (preDateArr.count == 3) {
        preDateStr = [NSString stringWithFormat:@"%@-%@-%@",
                      preDateArr[0],preDateArr[1],preDateArr[2]];
        dateStr = [NSString stringWithFormat:@"%@-%@",
                   preDateArr[1],preDateArr[2]];
    }
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:timeStr];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            fmt.dateFormat = @"今天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return preDateStr;
    }
}

////weiChat Time Type
- (NSString *)alipayCreatAlipyBilltime:(NSString *)timeStr {
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    // [yyyy-mm-dd] [hh:mm]
    NSArray *dateArr = [timeStr componentsSeparatedByString:@" "];
    //[yyyy,mm,dd]
    NSArray *preDateArr = [[dateArr firstObject] componentsSeparatedByString:@"-"];
    NSString *preDateStr;
    NSString *dateStr;
    if (preDateArr.count == 3) {
        preDateStr = [NSString stringWithFormat:@"%@-%@-%@",
                      preDateArr[0],preDateArr[1],preDateArr[2]];
        dateStr = [NSString stringWithFormat:@"%@-%@",
                   preDateArr[1],preDateArr[2]];
    }
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:timeStr];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            fmt.dateFormat = @"今天 HH:mm";
            return [fmt stringFromDate:create];
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return preDateStr;
    }
}
-(NSString *)addTime:(NSString *)timeStr
{
    // 日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    
    BOOL hasAMPM = containsA.location != NSNotFound;
    // NSLog(@"是否是12小时制--%d",hasAMPM);
    //hasAMPM==TURE为12小时制，否则为24小时制
    
    // 日期格式化类
    NSDateFormatter *ATZt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    ATZt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSArray *dateArr = [timeStr componentsSeparatedByString:@" "];
  
    NSArray *preDateArr = [[dateArr firstObject] componentsSeparatedByString:@"-"];
    NSString *preDateStr;
    NSString *dateStr;
    if (preDateArr.count == 3) {
        preDateStr = [NSString stringWithFormat:@"%@年%@月%@日",
                      preDateArr[0],preDateArr[1],preDateArr[2]];
        dateStr = [NSString stringWithFormat:@"%@月%@",
                   preDateArr[1],preDateArr[2]];
    }
    
    // 帖子的创建时间
    NSDate *create = [ATZt dateFromString:timeStr];
    
    /*
    if (create.isThisYear) { // 今年
        if ([calendar isDateInToday:create]) { // 今天
            
            if (hasAMPM) {   //12小时制
                NSDateComponents *cmps = [create dateComponets];
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }
                
            }else {
                ATZt.dateFormat = @"HH:mm";
            }
            return [ATZt stringFromDate:create];
            
        } else if ([calendar isDateInYesterday:create]) { // 昨天
            if (hasAMPM) {
                NSDateComponents *cmps = [create dateComponets];
                
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        ATZt.dateFormat = @"昨天 aaah:mm";
                    }else{
                        ATZt.dateFormat = @"昨天 aaahh:mm";
                    }
                }
                
            }else {
                ATZt.dateFormat = @"昨天 HH:mm";
            }
            
            return [ATZt stringFromDate:create];
            
        }else if([calendar isDateInWeekend:create]){//if (create.isThisWeak){
            
            ATZt.weekdaySymbols = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
            if (hasAMPM) {
                NSDateComponents *cmps = [create dateComponets];
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"EEEE aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"EEEE aaah:mm";
                    }else{
                        ATZt.dateFormat = @"EEEE aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        ATZt.dateFormat = @"EEEE aaah:mm";
                    }else{
                        ATZt.dateFormat = @"EEEE aaahh:mm";
                    }
                }
            }else {
                ATZt.dateFormat = @"EEEE HH:mm";
            }
            
            return [ATZt stringFromDate:create];
        }else { // 其他
            
            if (hasAMPM) {
                NSDateComponents *cmps = [create dateComponets];
                
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        
                        ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaah:mm ",dateStr];
                    }else{
                        ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaahh:mm ",dateStr];
                    }
                }
                
            }else {
                ATZt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",dateStr];
            }
            
            return [ATZt stringFromDate:create];
        }
    } else { // 非今年
        if (hasAMPM) {
            NSDateComponents *cmps = [create dateComponets];
            
            if (cmps.hour<=5) {
                ATZt.AMSymbol = @"凌晨";
                ATZt.dateFormat = @"aaah:mm";
            }else if (cmps.hour<=12){
                
                ATZt.AMSymbol = @"上午";
                if (cmps.hour<10) {
                    ATZt.dateFormat = @"aaah:mm";
                }else{
                    ATZt.dateFormat = @"aaahh:mm";
                }
            }else {
                ATZt.PMSymbol = @"下午";
                if (cmps.hour%12 <10) {
                    
                    ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaah:mm ",preDateStr];
                }else{
                    ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaahh:mm ",preDateStr];
                }
            }
            
        }else {
            ATZt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",preDateStr];
        }
        return [ATZt stringFromDate:create];
    }
     */
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            
            if (hasAMPM) {   //12小时制
                NSDateComponents *cmps = [create dateComponets];
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }
                
            }else {
                ATZt.dateFormat = @"HH:mm";
            }
            return [ATZt stringFromDate:create];
            
        } else if (create.isYesterday) { // 昨天
            if (hasAMPM) {
                NSDateComponents *cmps = [create dateComponets];
                
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        ATZt.dateFormat = @"昨天 aaah:mm";
                    }else{
                        ATZt.dateFormat = @"昨天 aaahh:mm";
                    }
                }
                
            }else {
                ATZt.dateFormat = @"昨天 HH:mm";
            }
            
            return [ATZt stringFromDate:create];
            
        }else if (create.isThisWeak){
            
            ATZt.weekdaySymbols = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
            if (hasAMPM) {
                NSDateComponents *cmps = [create dateComponets];
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"EEEE aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"EEEE aaah:mm";
                    }else{
                        ATZt.dateFormat = @"EEEE aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        ATZt.dateFormat = @"EEEE aaah:mm";
                    }else{
                        ATZt.dateFormat = @"EEEE aaahh:mm";
                    }
                }
            }else {
                ATZt.dateFormat = @"EEEE HH:mm";
            }
            
            return [ATZt stringFromDate:create];
        }else { // 其他
            
            if (hasAMPM) {
                NSDateComponents *cmps = [create dateComponets];
                
                if (cmps.hour<=5) {
                    ATZt.AMSymbol = @"凌晨";
                    ATZt.dateFormat = @"aaah:mm";
                }else if (cmps.hour<=12){
                    
                    ATZt.AMSymbol = @"上午";
                    if (cmps.hour<10) {
                        ATZt.dateFormat = @"aaah:mm";
                    }else{
                        ATZt.dateFormat = @"aaahh:mm";
                    }
                }else {
                    ATZt.PMSymbol = @"下午";
                    if (cmps.hour%12 <10) {
                        
                        ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaah:mm ",dateStr];
                    }else{
                        ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaahh:mm ",dateStr];
                    }
                }
                
            }else {
                ATZt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",dateStr];
            }
            
            return [ATZt stringFromDate:create];
        }
    } else { // 非今年
        if (hasAMPM) {
            NSDateComponents *cmps = [create dateComponets];
            
            if (cmps.hour<=5) {
                ATZt.AMSymbol = @"凌晨";
                ATZt.dateFormat = @"aaah:mm";
            }else if (cmps.hour<=12){
                
                ATZt.AMSymbol = @"上午";
                if (cmps.hour<10) {
                    ATZt.dateFormat = @"aaah:mm";
                }else{
                    ATZt.dateFormat = @"aaahh:mm";
                }
            }else {
                ATZt.PMSymbol = @"下午";
                if (cmps.hour%12 <10) {
                    
                    ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaah:mm ",preDateStr];
                }else{
                    ATZt.dateFormat = [NSString stringWithFormat:@"%@ aaahh:mm ",preDateStr];
                }
            }
            
        }else {
            ATZt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",preDateStr];
        }
        return [ATZt stringFromDate:create];
    }
    
}

//返回当前日期 区分上午 下午
+(NSString *)getCurrentTimeWithformat:(NSString *)formatStr{
    
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [fmt setDateFormat:formatStr];
    
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    
    if (hasAMPM) {
        NSDateComponents *cmps = [datenow dateComponets];
        
        if (cmps.hour<=5) {
            fmt.AMSymbol = @"凌晨";
            fmt.dateFormat = @"aaah:mm";
        }else if (cmps.hour<=12){
            
            fmt.AMSymbol = @"上午";
            if (cmps.hour<10) {
                fmt.dateFormat = @"aaah:mm";
            }else{
                fmt.dateFormat = @"aaahh:mm";
            }
        }else {
            fmt.PMSymbol = @"下午";
            if (cmps.hour%12 <10) {
                fmt.dateFormat = @"aaah:mm";
            }else{
                fmt.dateFormat = @"aaahh:mm";
            }
        }
        
    }else {
        fmt.dateFormat = @"HH:mm";
    }
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [fmt stringFromDate:datenow];
    //    NSLog(@"currentTimeString =  %@",currentTimeString);
    return currentTimeString;
}

+ (NSString *)getTheCurrentTimeisdividedIntoeconds{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
    
}

- (NSString *)randomNumStrWithNum:(NSInteger)num {
    
    NSString *numStr = @"";
    for (int i = 0; i < num; i++) {
        NSString *aOrderStr = [NSString stringWithFormat:@"%.4d",arc4random()%10000];
        numStr = [NSString stringWithFormat:@"%@%@",numStr,aOrderStr];
    }
    return numStr;
}


+ (NSString *)getCurrtnTimeSp {
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    return timeString;
}

/**
 *  获取未来某个日期是星期几
 *  注意：featureDate 传递过来的格式 必须 和 formatter.dateFormat 一致，否则endDate可能为nil
 *
 */

- (NSString *)featureWeekdayWithDate:(NSString *)featureDate{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [formatter dateFromString:featureDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:[NSDate date] toDate:endDate];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = [self getNowWeekday] + day;
    switch (week) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
            
        default:
            break;
    }
    return nil;
}

/**
 *  计算2个日期相差天数
 *  startDate   起始日期
 *  endDate     截至日期
 */
-(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0) {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days + 1;
    }
}

// 获取当前是星期几
- (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}


- (NSString*)weekDayStr:(NSString*)format{
    
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if(format.length>=10) {
        NSString *nowString = [format substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if(array.count==0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        
        if(array.count>=3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取传入date
    NSDate *_date = [gregorian dateFromComponents:comps];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    switch(week) {
        case 1:
            weekDayStr =@"星期日";
            break;
        case 2:
            weekDayStr =@"星期一";
            break;
        case 3:
            weekDayStr =@"星期二";
            break;
        case 4:
            weekDayStr =@"星期三";
            break;
        case 5:
            weekDayStr =@"星期四";
            break;
        case 6:
            weekDayStr =@"星期五";
            break;
        case 7:
            weekDayStr =@"星期六";
            break;
        default:
            weekDayStr =@"";
            break;
    }
    return weekDayStr;
}








- (NSString *)MD5HashString {
    
    return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5HashString];
}

- (NSString *)timeWithTimeIntervalString:(NSString *)timeString {
    
    NSTimeInterval time=[timeString doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    
    NSDate*detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}

- (NSString *)aboutMonth {
    
    BOOL isThisMonth = [[NSDate alloc] isThisMonth:self];
    BOOL isThisYear = [[NSDate alloc] isThisYear:self];
    
    NSArray *dateArr = [self componentsSeparatedByString:@" "];
    
    if (isThisYear) {
        if (isThisMonth) {
            return @"本月";
        }else {
            NSString *preStr = [dateArr firstObject];
            NSArray *subDataArr = [preStr componentsSeparatedByString:@"-"];
            NSString *monthStr = [subDataArr objectAtIndex:1];
            if ([monthStr isEqualToString:@"01"]) {
                return @"一月";
            }else if ([monthStr isEqualToString:@"02"]) {
                return @"二月";
            }else if ([monthStr isEqualToString:@"03"]) {
                return @"三月";
            }else if ([monthStr isEqualToString:@"04"]) {
                return @"四月";
            }else if ([monthStr isEqualToString:@"05"]) {
                return @"五月";
            }else if ([monthStr isEqualToString:@"06"]) {
                return @"六月";
            }else if ([monthStr isEqualToString:@"07"]) {
                return @"七月";
            }else if ([monthStr isEqualToString:@"08"]) {
                return @"八月";
            }else if ([monthStr isEqualToString:@"09"]) {
                return @"九月";
            }else if ([monthStr isEqualToString:@"10"]) {
                return @"十月";
            }else if ([monthStr isEqualToString:@"11"]) {
                return @"十一月";
            }else if ([monthStr isEqualToString:@"12"]) {
                return @"十二月";
            }
        }
    }else {
        return [dateArr firstObject];
    }
    return @"";
}

/**
 金额显示逗号分隔
 
 @param string 需要处理的金额
 @return 转换后的
 */
+(NSString*)strmethodComma:(NSString*)string
{
    if (!string || [string isEqualToString:@"0"]) {
        return @"0.00";
    }
    
    NSString *sign = nil;
    if ([string hasPrefix:@"-"]||[string hasPrefix:@"+"]) {
        sign = [string substringToIndex:1];
        string = [string substringFromIndex:1];
    }
    
    if (string.length < 4) {
        if (sign) {
            string = [sign stringByAppendingString:string];
        }
        return string;
    }
    
    NSString *pointLast  = nil;
    NSString *pointFront = nil;
    NSInteger location   = [string rangeOfString:@"."].location;
    if (location != NSNotFound) {
        NSString *substring  = [string substringFromIndex:location];
        pointLast = [string substringFromIndex:[string length]-substring.length];
        pointFront = [string substringToIndex:[string length]-substring.length];
    }else {
        pointLast = @"";
        pointFront = string;
    }
    
    int commaNum = ([pointFront length]-1)/3;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < commaNum+1; i++) {
        int index = [pointFront length] - (i+1)*3;
        int leng = 3;
        if(index < 0)
        {
            leng = 3+index;
            index = 0;
        }
        NSRange range = {index,leng};
        NSString *stq = [pointFront substringWithRange:range];
        [arr addObject:stq];
    }
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = [arr count]-1; i>=0; i--) {
        
        [arr2 addObject:arr[i]];
    }
    NSString *commaString = [[arr2 componentsJoinedByString:@","] stringByAppendingString:pointLast];
    
    if (sign) {
        commaString = [sign stringByAppendingString:commaString];
    }
    return commaString;
    
}
@end
