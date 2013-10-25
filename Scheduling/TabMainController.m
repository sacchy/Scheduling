//
//  TabMainController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "TabMainController.h"
//#import "DroppyAppDelegate.h"
//
//#import "SLSQLite.h"
//#import "EventController.h"
//#import "ScheduleController.h"
//#import "GenreController.h"
//#import "SettingController.h"
//#import "UserController.h"
//#import "LocationController.h"
//
//#import "SFHFKeychainUtils.h"
//#import "Event.h"

#define TAB_INDEX_TIMELINE 0
#define TAB_INDEX_RECOMMEND 2
#define TAB_INDEX_CALENDAR 1
#define TAB_INDEX_ACCOUNT 3

@implementation TabMainController
@synthesize tabBarController;

- (id)init
{
    self = [super init];
    if (self)
    {
        NSLog(@"tab init");
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"tab");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
