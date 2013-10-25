//
//  SLDateUtil.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "SLDateUtil.h"
//#import "Logger.h"

@implementation SLDateUtil
static NSString *dateTimeFormatString = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
static NSString *dateTimeZoneFormatString = @"yyyy-MM-dd'T'HH:mm:ssZZ";
static NSString *dateFormatString = @"yyyy-MM-dd";

static ORSDateFormat _dateFormat;

+ (void)setSerializeFormat:(ORSDateFormat)dateFormat {
	_dateFormat = dateFormat;
}

+ (void)setDateFormatString:(NSString *)format {
	dateFormatString = format;
}

+ (void)setDateTimeFormatString:(NSString *)format {
	dateTimeFormatString = format;
}

+ (void)setDateTimeZoneFormatString:(NSString *)format {
	dateTimeZoneFormatString = format;
}

+ (NSString *)formatDate:(NSDate *)date {
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	if(_dateFormat == Date) {
		[formatter setDateFormat:dateFormatString];
	}
	else {
		[formatter setDateFormat:dateTimeFormatString];		
	}
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter stringFromDate:date];
    
}

+ (NSDate *)parseDateTime:(NSString *)dateTimeString {
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *format=dateTimeZoneFormatString;
    if ([dateTimeString hasSuffix:@"Z"]) {
        format=dateTimeFormatString;
    }else{
        //一番後ろの:を消す
        dateTimeString=[dateTimeString stringByReplacingOccurrencesOfString:@"+09:00" withString:@"+0900"];
    }

	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:format];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter dateFromString:dateTimeString];
}

+ (NSDate *)parseDate:(NSString *)dateString {
    
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:dateFormatString];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter dateFromString:dateString];
    
}

+(NSString*)parseDateString:(NSDate*)date formatString:(NSString*)formatString
{
	NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
	[fmt setDateFormat:formatString];
	return [fmt stringFromDate:date];
}

+(NSString*)parseDayString:(NSDate *)date{
    NSString *ret = [NSString string];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps= [calendar components:(NSWeekdayCalendarUnit)
                        fromDate:date];
    NSInteger weekday = [comps weekday]; // 曜日
    switch (weekday) {
        case 1:
            ret = NSLocalizedString(@"Sunday", @"DateFormat");
            break;
        case 2:
            ret = NSLocalizedString(@"Monday", @"DateFormat");
            break;
        case 3:
            ret = NSLocalizedString(@"Tuesday", @"DateFormat");
            break;
        case 4:
            ret = NSLocalizedString(@"Wednesday", @"DateFormat");
            break;
        case 5:
            ret = NSLocalizedString(@"Thursday", @"DateFormat");
            break;
        case 6:
            ret = NSLocalizedString(@"Friday", @"DateFormat");
            break;
        case 7:
            ret = NSLocalizedString(@"Saturday", @"DateFormat");
            break;
        default:
            break;
    }
    return ret;
}

+(BOOL)isAllDay:(NSDate*)startDate endDate:(NSDate*)endDate{
    BOOL ret = NO;
    
    /* 235959にできない 鯖がssを使えない */
    if ([[SLDateUtil parseDateString:startDate formatString:@"HHmmss"] isEqualToString:@"000000"]
        && [[SLDateUtil parseDateString:endDate formatString:@"HHmmss"] isEqualToString:@"235900"]) {
        ret = YES;
    }
    return ret;
}

+(BOOL)isEquealDate:(NSDate*)startDate endDate:(NSDate*)endDate{
    BOOL ret = NO;
    
    if ([[SLDateUtil parseDateString:endDate formatString:@"yyyyMMdd"] isEqualToString:[SLDateUtil parseDateString:startDate formatString:@"yyyyMMdd"]]) {
        ret = YES;
    }
    return ret;
}

+(NSString*)parsePeriodString:(NSDate*)startDate endDate:(NSDate*)endDate{
    NSString *ret = [NSString string];
    //終日の場合は日付のみ
    if ([SLDateUtil isAllDay:startDate endDate:endDate]) 
    {
        if ([SLDateUtil isEquealDate:startDate endDate:endDate]) {
            //同日の場合
            ret = [NSString stringWithFormat:@"%@%@"
                   ,[SLDateUtil parseDateString:startDate formatString:NSLocalizedString(@"DateFormatMMDD", @"DateFormat")]
                   ,[SLDateUtil parseDayString:startDate]];
        }else{
            //日またぎの場合
            ret = [NSString stringWithFormat:@"%@%@\n - %@%@"
                   ,[SLDateUtil parseDateString:startDate formatString:NSLocalizedString(@"DateFormatMMDD", @"DateFormat")]
                   ,[SLDateUtil parseDayString:startDate]
                   ,[SLDateUtil parseDateString:endDate formatString:NSLocalizedString(@"DateFormatMMDD", @"DateFormat")]
                   ,[SLDateUtil parseDayString:endDate]];
            
        }
    }else if ([SLDateUtil isEquealDate:startDate endDate:endDate]) {
        //開始日と終了日が同日の場合 MM月dd日(曜日)HH:mm〜HH:mm
        ret=
        [NSString stringWithFormat:@"%@%@%@ - %@"
         ,[SLDateUtil parseDateString:startDate formatString:NSLocalizedString(@"DateFormatMMDD", @"DateFormat")]
         ,[SLDateUtil parseDayString:startDate]
         ,[SLDateUtil parseDateString:startDate formatString:@"HH:mm"]
         ,[SLDateUtil parseDateString:endDate formatString:@"HH:mm"]];
    }else{
        ret=
        [NSString stringWithFormat:@"%@%@%@\n - %@%@%@"
         ,[SLDateUtil parseDateString:startDate formatString:NSLocalizedString(@"DateFormatMMDD", @"DateFormat")]
         ,[SLDateUtil parseDayString:startDate]
         ,[SLDateUtil parseDateString:startDate formatString:@"HH:mm"]
         ,[SLDateUtil parseDateString:endDate formatString:NSLocalizedString(@"DateFormatMMDD", @"DateFormat")]
         ,[SLDateUtil parseDayString:endDate]
         ,[SLDateUtil parseDateString:endDate formatString:@"HH:mm"]];
    }
    return ret;
}

//時差補正
+(NSDate*)getNow{
    return [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
}


@end
