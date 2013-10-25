//
//  TabMainController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineViewController.h"
#import "ShowUserViewController.h"

@interface TabMainController : UIViewController<UITabBarControllerDelegate>
{
    TimelineViewController *timelineViewController;
    ShowUserViewController *showUserViewController;
}

@property (strong, nonatomic) UITabBarController *tabBarController;
@end
