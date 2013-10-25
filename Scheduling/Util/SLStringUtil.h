//
//  StringUtils.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SLStringUtil : NSObject {

}

+(NSMutableString*)convUnderScoreToCamel:(NSString*)value;
+(NSData*)convNullToBlankData:(NSData*)nullData;
+(NSString*)convNullToBlank:(NSString*)nullString;
+(NSString*)convNullToBlankForInt:(NSString*)nullString;
+(NSString*)convTimeToString:(NSString*)timeString;
+(NSString*)convStringToTime:(NSString*)fmtString;
+(NSString*)convSecondsToString:(int)timeSeconds;

+(NSString *)stringByURLEncoding:(NSString*)str encording:(NSStringEncoding)encoding;
+(BOOL)isOnlyHalf:(NSString *)str;

+(NSMutableDictionary*)convURLParamsToDictionary:(NSString*)paramString;

+(BOOL)notNull:(id)value;

@end
