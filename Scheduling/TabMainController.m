//
//  TabMainController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "TabMainController.h"

@implementation TabMainController
@synthesize tabBarController;

- (id)init
{
    self = [super init];
    if (self)
    {

    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timelineViewController = [[TimelineViewController alloc] init];
    UINavigationController *timelineNav = [[UINavigationController alloc] initWithRootViewController:timelineViewController];
    timelineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"TimeLine", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"tl.png"]
                                                       tag:1];
    
    showUserViewController = [[ShowUserViewController alloc] init];
    UINavigationController *showUserNav = [[UINavigationController alloc] initWithRootViewController:showUserViewController];
    showUserNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"User", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"user.png"]
                                                       tag:2];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:timelineNav];
    [array addObject:showUserNav];
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = array;
    tabBarController.view.frame = self.view.bounds;
    [self.view addSubview:tabBarController.view];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
