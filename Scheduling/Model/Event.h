//
//  Event.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    NSMutableDictionary *dic_event;
    NSMutableDictionary *dic_relation;    
}
- (id)initWithData:(NSMutableDictionary*)dic;
- (NSMutableDictionary*)getDictionary;

@property(nonatomic,assign) NSInteger scheduleId;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *details;
@property(nonatomic,assign) NSInteger creatorId;

@property(nonatomic,retain) NSString *userName;
@property(nonatomic,retain) NSString *iconPath;

@end
