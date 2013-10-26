//
//  Logger.h
//  Droppy
//
//  Created by 功司 木山 on 12/02/23.
//  Copyright (c) 2012年 subakolab. All rights reserved.
//

#ifdef DEBUG
#   define TRACE(fmt, ...) NSLog((@"%s(%d) " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define TRACE(...)
#endif

@interface Logger : NSObject

@end
