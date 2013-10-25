//
//  TabMainController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import "TimelineViewController.h"
//#import "IndexRecommendViewController.h"
//#import "CalendarViewController.h"
//#import "SLNetworkManagers.h"
//#import "ShowUserViewController.h"
//#import "SearchEventViewController.h"

@interface TabMainController : UIViewController<UITabBarControllerDelegate>
{
    @private

//    TimelineViewController *tlVc;
//    CalendarViewController *clVc;
//    ShowUserViewController *suVc;
//    SearchEventViewController* seVc;
    
    UIImageView *iv;    //起動時イメージ
    NSMutableArray *events;
    
}

@property (strong, nonatomic) UITabBarController *tabBarController;
@end
