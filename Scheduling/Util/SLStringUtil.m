//
//  StringUtils.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "SLStringUtil.h"


@implementation SLStringUtil

+(NSMutableString*)convUnderScoreToCamel:(NSString*)value
{
	BOOL found = YES;
	
	NSMutableString *ret = [NSMutableString string];
	[ret appendString:value];

	while (found==YES) {
		//アンダーバーを探す
		NSRange searchResult = [ret rangeOfString:@"_"];
		if(searchResult.location == NSNotFound){
			// みつからない場合
			found=NO;
		}else{
			// みつかった場合
			//アンダーバーを消す
			[ret replaceCharactersInRange:NSMakeRange(searchResult.location,1) withString:[NSString string]];
			
			//アンダーバーの後ろに文字がある
			if (searchResult.location < value.length ) {
				//次の文字をUCASE
				NSString *str = [ret substringWithRange:NSMakeRange(searchResult.location,1)];
				str = [str uppercaseString];
				[ret replaceCharactersInRange:NSMakeRange(searchResult.location,1) withString:str];
			}
		}
	}
	
	return ret;
}

+(NSData*)convNullToBlankData:(NSData*)nullData;
{
    NSData* ret=nullData;
	if (!nullData || [nullData isEqual:@"(null)"] || [nullData isEqual:[NSNull null]]) {
		ret = [NSString string];
	}
    return ret;
}

+(NSString*)convNullToBlank:(NSString*)nullString
{
	NSString* ret=nullString;
	if (!nullString || [nullString isEqual:@"(null)"] || [nullString isEqual:[NSNull null]]) {
		ret = [NSString string];
	}
	return ret;
}

+(NSString*)convNullToBlankForInt:(NSString*)nullString
{
	NSString* ret=nullString;
	if (!nullString || [nullString isEqual:@"(null)"] || [nullString isEqual:[NSNull null]]) {
		ret = @"-1";
	}
	return ret;
}

+(NSString*)convTimeToString:(NSString*)timeString
{
	//分→XX時間XX分
	NSString *ret;
	int minutes = [timeString intValue] % 60;
	int hours = ([timeString intValue]-minutes)/60;
	
	if ([timeString intValue]>0) {
		ret = [[NSString alloc] initWithFormat:@"%02d時間%02d分",hours,minutes];
	}
	else {
		ret = [NSString string];
	}


	return ret;
}

+(NSString*)convSecondsToString:(int)timeSeconds
{
	//秒→00:00:00
	NSString *ret;
	
	int seconds = timeSeconds % 60;
	int minutes = ((timeSeconds-seconds)/60) % 60;
	int hours = (timeSeconds-seconds-minutes*60.0)/60;
	
	if (timeSeconds>0.0) {
		ret = [[NSString alloc] initWithFormat:@"%02d:%02d:%02d",hours,minutes,seconds];
	}
	else {
		ret = [NSString string];
	}
	
	return ret;
}


+(NSString*)convStringToTime:(NSString*)fmtString
{
	//XX時間XX分→分
	//とりあえず桁数で切るか。。
	NSString *ret;
	if (fmtString.length>6) {
		int hours = [[fmtString substringWithRange:NSMakeRange(0,2)] intValue];
		int minutes = [[fmtString substringWithRange:NSMakeRange(4,2)] intValue];
		
		int totalMinutes = hours*60+minutes;
		if (totalMinutes>1) {
			ret=[[NSString alloc] initWithFormat:@"%d",totalMinutes];
		}
		else {
			ret=[NSString string];
		}
	}
	else {
		ret=fmtString;
	}
	
	return ret;
}


/* URLエンコード */
+(NSString *)stringByURLEncoding:(NSString*)str encording:(NSStringEncoding)encoding
{
    NSArray *escapeChars = [NSArray arrayWithObjects:
                            @";" ,@"/" ,@"?" ,@":"
                            ,@"@" ,@"&" ,@"=" ,@"+"
                            ,@"$" ,@"," ,@"[" ,@"]"
                            ,@"#" ,@"!" ,@"'" ,@"("
                            ,@")" ,@"*"
                            ,nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:
                             @"%3B" ,@"%2F" ,@"%3F"
                             ,@"%3A" ,@"%40" ,@"%26"
                             ,@"%3D" ,@"%2B" ,@"%24"
                             ,@"%2C" ,@"%5B" ,@"%5D"
                             ,@"%23" ,@"%21" ,@"%27"
                             ,@"%28" ,@"%29" ,@"%2A"
                             ,nil];
    
    NSMutableString *encodedString = [[str stringByAddingPercentEscapesUsingEncoding:encoding] mutableCopy];
    
    for(int i=0; i<[escapeChars count]; i++) {
        [encodedString replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                                       withString:[replaceChars objectAtIndex:i]
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [encodedString length])];
    }
    
    return [NSString stringWithString: encodedString];
}

/* 入力文字列を1文字ずつURLエンコードし、文字列長が4以上だったら全角文字と判定 */
+(BOOL)isOnlyHalf:(NSString *)str {
	for(int i=0; i<[str length]; i++) {
		NSString *aChar = [str substringWithRange:NSMakeRange(i, 1)];
		NSString *encodedChar = [self stringByURLEncoding:aChar encording :NSUTF8StringEncoding];
		if ([encodedChar length] < 4) {
			continue;
		}
		else {
			return NO;
		}
	}
	return YES;
}

//URLパラメータをDictionary化する
+(NSMutableDictionary*)convURLParamsToDictionary:(NSString*)paramString{
    NSMutableDictionary *ret = [NSMutableDictionary dictionary];
    //&で区切って配列にする
    NSArray *array = [paramString componentsSeparatedByString:@"&"];
    for(NSString *str in array){
        //=の前がkey後ろがvalue
        NSRange range = [str rangeOfString:@"="];
        if (range.location != NSNotFound) {
            [ret setObject:[str substringFromIndex:range.location+1] forKey:[str substringToIndex:range.location]];
        }
    }
    
    return ret;
}

//nullチェック
+(BOOL)notNull:(id)value{
    BOOL ret = YES;
    if (!value || [value isEqual:@"(null)"] || [value isEqual:[NSNull null]]) {
        ret = NO;
    }
    return ret;
}

@end
