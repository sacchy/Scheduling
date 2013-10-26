//
//  IndexEventViewController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexViewController.h"

typedef enum IndexEventViewControllerType
{
    IndexEventViewControllerTypeNone,
    IndexEventViewControllerTypeMyEvent,
} IndexEventViewControllerType;

@interface IndexEventViewController : IndexViewController
{
@protected
    NSInteger userId_;
    NSInteger type_;
}

- (id)initWithType:(IndexEventViewControllerType)type user:(NSInteger)userID;

@end
