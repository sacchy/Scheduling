//
//  User.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/27.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "User.h"
#import "SLStringUtil.h"

@implementation User
@synthesize userName, count;

// Dictionaryからモデルを作成
- (id)initWithData:(NSMutableDictionary*)dic
{
    self = [super init];
    if (self)
    {
        self.userName = [dic objectForKey:@"user_name"];
        self.count = [[SLStringUtil convNullToBlankForInt:[dic objectForKey:@"count"]] intValue];
    }
    return self;
}

// モデルからDictionaryを取得
- (NSMutableDictionary*)getDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // この値でセットした辞書をGET
    [dic setObject:[SLStringUtil convNullToBlank:userName] forKey:@"user_name"];
    [dic setObject:[NSNumber numberWithInt:count]          forKey:@"count"];
    return dic;
}
@end
