//
//  SLDateUtil.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLDateUtil : NSObject
typedef enum {
	Date = 0,
	DateTime,
} ORSDateFormat;

+ (void)setSerializeFormat:(ORSDateFormat)dateFormat;
+ (void)setDateFormatString:(NSString *)format;
+ (void)setDateTimeFormatString:(NSString *)format;
+ (void)setDateTimeZoneFormatString:(NSString *)format;
+ (NSString *)formatDate:(NSDate *)date;
+ (NSDate *)parseDate:(NSString *)dateString;
+ (NSDate *)parseDateTime:(NSString *)dateTimeString;

+(NSString*)parseDateString:(NSDate*)date formatString:(NSString*)formatString;
+(NSString*)parseDayString:(NSDate*)date;

+(BOOL)isAllDay:(NSDate*)startDate endDate:(NSDate*)endDate;
+(BOOL)isEquealDate:(NSDate*)startDate endDate:(NSDate*)endDate;
+(NSString*)parsePeriodString:(NSDate*)startDate endDate:(NSDate*)endDate;

+(NSDate*)getNow;

@end
