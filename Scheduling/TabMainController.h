//
//  TabMainController.h
//  droppy
//
//  Created by 佐藤 昌樹 on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TimelineViewController.h"
#import "IndexRecommendViewController.h"
#import "CalendarViewController.h"
#import "SLNetworkManagers.h"
#import "ShowUserViewController.h"
#import "SearchEventViewController.h"

@interface TabMainController : UIViewController<UITabBarControllerDelegate>
{
    @private

    TimelineViewController *tlVc;
    CalendarViewController *clVc;
    ShowUserViewController *suVc;
    SearchEventViewController* seVc;
    
    UIImageView *iv;    //起動時イメージ
    NSMutableArray *events;
    
}

@property (strong, nonatomic) UITabBarController *tabBarController;
@end
