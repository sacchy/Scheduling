//
//  Event.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "Event.h"
#import "SLStringUtil.h"

@implementation Event

@synthesize scheduleId, name, details, creatorId, userName, iconPath;

// Dictionaryからモデルを作成
- (id)initWithData:(NSMutableDictionary*)dic
{
    self = [super init];
    if (self) 
    {
        self.name = [dic objectForKey:@"name"];
        self.scheduleId = [[SLStringUtil convNullToBlankForInt:[dic objectForKey:@"schedule_id"]] intValue];
        self.creatorId = [[SLStringUtil convNullToBlankForInt:[dic objectForKey:@"creator_id"]] intValue];
        self.iconPath = [NSString stringWithFormat:@"%@",[dic objectForKey:@"icon_path"]];
        self.userName = [dic objectForKey:@"user_name"];
        self.details = [dic objectForKey:@"details"];
     }
    return self;
}

// モデルからDictionaryを取得
- (NSMutableDictionary*)getDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    // この値でセットした辞書をGET
    [dic setObject:[NSNumber numberWithInt:scheduleId]          forKey:@"schedule_id"];
    [dic setObject:[SLStringUtil convNullToBlank:name]          forKey:@"name"];
    [dic setObject:[NSNumber numberWithInt:creatorId]           forKey:@"creator_id"];
    [dic setObject:[SLStringUtil convNullToBlank:iconPath]      forKey:@"icon_path"];
    [dic setObject:[SLStringUtil convNullToBlank:userName]      forKey:@"user_name"];
    [dic setObject:[SLStringUtil convNullToBlank:details]       forKey:@"details"];
    return dic;
}
@end
