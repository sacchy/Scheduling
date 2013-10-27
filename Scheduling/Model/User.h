//
//  User.h
//  Scheduling
//
//  Created by 佐藤 昌樹 on 2013/10/27.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

- (id)initWithData:(NSMutableDictionary*)dic;
- (NSMutableDictionary*)getDictionary;

@property(nonatomic,retain) NSString *userName;
@property(nonatomic,assign) NSInteger count;

@end
