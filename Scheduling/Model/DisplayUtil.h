//
//  DisplayUtil.h
//  Scheduling
//
//  Created by 佐藤 昌樹 on 2013/10/27.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisplayUtil : NSObject

+ (void)calcLabelHeight:(UILabel*)label;
+ (UIButton*)createCountButton:(NSInteger)count unitText:(NSString*)unit;
+ (void)setViewProperties:(NSMutableDictionary*)properties view:(UIView *)view;

@end
