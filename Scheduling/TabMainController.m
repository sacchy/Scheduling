//
//  TabMainController.m
//  droppy
//
//  Created by 佐藤 昌樹 on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TabMainController.h"
#import "DroppyAppDelegate.h"

#import "SLSQLite.h"
#import "EventController.h"
#import "ScheduleController.h"
#import "GenreController.h"
#import "SettingController.h"
#import "UserController.h"
#import "LocationController.h"

#import "SFHFKeychainUtils.h"
#import "Event.h"

#define TAB_INDEX_TIMELINE 0
#define TAB_INDEX_RECOMMEND 2
#define TAB_INDEX_CALENDAR 1
#define TAB_INDEX_ACCOUNT 3

@implementation TabMainController
@synthesize tabBarController;

- (id)init
{
    self = [super init];
    if (self) {
        
        //SQLiteマイグレーション
        NSInteger result = 0;
        SLSQLite *sqlite = [[SLSQLite alloc] init];
        [sqlite open];
        [sqlite begin];
        
        //イベント
        EventController *ec = [[EventController alloc] initWidhDB:sqlite];
        result = [ec migrate];
        
        //スケジュール
        if (result > -1) {
            ScheduleController *sc = [[ScheduleController alloc] initWidhDB:sqlite];
            result = [sc migrate];
        }
        
        //ジャンル
        if (result > -1) {
            GenreController *gc = [[GenreController alloc] initWidhDB:sqlite];
            result = [gc migrate];
        }
        
        //ロケーション
        if (result > -1) {
            LocationController *lc = [[LocationController alloc] initWidhDB:sqlite];
            result = [lc migrate];
        }
        
        //設定
        if (result > -1) {
            SettingController *setc = [[SettingController alloc] initWidhDB:sqlite];
            result = [setc migrate];
        }
        
        //ユーザー
        if (result > -1) {
            UserController *uc = [[UserController alloc] initWidhDB:sqlite];
            result = [uc migrate];
        }
        
        if(result > -1){
            [sqlite commit];
        }else{
            [sqlite rollback];
        }
        
        [sqlite close];
        
        
    }
    return self;
}

#pragma mark - View lifecycle

-(void) viewDidLoad
{
    [super viewDidLoad];    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    [iv removeFromSuperview];
    
    //初回のみローカルデータを先に呼び出す
    /*events = [NSMutableArray array];
    
    SLSQLite *sqlite = [[SLSQLite alloc] init];
    [sqlite open];
    EventController *ec = [[EventController alloc] initWidhDB:sqlite];
    
    NSMutableArray *dataArray = [ec find:[NSMutableString string]];
    Event *event = [[Event alloc] initWithData:[dataArray objectAtIndex:0]];
    NSLog(@"id:%d",event.serverId);
     */
    /*
    for(NSMutableDictionary *dic in dataArray)
    {
        NSLog(@"110");
        Event *event = [[Event alloc] initWithData:dic];
        [events addObject:event];
    }
     */
    //[sqlite close];
    
    //画面表示
    NSMutableArray *array = [NSMutableArray array];
    
#if 0    
    /* カレンダー */
    clVc = [[CalendarViewController alloc] initWithCreatorId:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
    clVc.delegate = (id)self;
    UINavigationController *clNav=[[UINavigationController alloc] initWithRootViewController:clVc];
    clNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Calendar", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"droppyTabCal.png"] 
                                                       tag:TAB_INDEX_CALENDAR];
    clNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
#endif
    
    //タイムライン
/*    
    tlVc = [[TimelineViewController alloc] initWithType:IndexEventViewControllerTypeNone 
                                                   user:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
    UINavigationController *tlNav=[[UINavigationController alloc] initWithRootViewController:tlVc];
    tlNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Timeline", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"droppyTabTL.png"] 
                                                       tag:TAB_INDEX_TIMELINE];
    tlNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
    */
    
    IndexEventViewController *ieVc = [[IndexEventViewController alloc] initWithType:IndexEventViewControllerTypeNone 
                                                                              user:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
    UINavigationController *ieNav=[[UINavigationController alloc] initWithRootViewController:ieVc];
    ieNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Timeline", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"droppyTabTL.png"] 
                                                       tag:TAB_INDEX_TIMELINE];
    ieNav.navigationBar.barStyle = UIBarStyleBlackOpaque;

#if 1
    //オススメ
    IndexUserViewController *iuVc = [[IndexUserViewController alloc] initWithType:IndexUserViewControllerTypeRecommend
                                                                             user:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
    UINavigationController *iuNav = [[UINavigationController alloc] initWithRootViewController:iuVc];
    iuNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Recommend", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"droppyTabRecommend.png"] 
                                                       tag:TAB_INDEX_RECOMMEND];
    iuNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    //検索
    seVc = [[SearchEventViewController alloc] init];
    UINavigationController *seNav=[[UINavigationController alloc] initWithRootViewController:seVc];
    seNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Search", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"droppyTabSearch.png"] 
                                                       tag:TAB_INDEX_ACCOUNT];
    seNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    //アカウント
    suVc = [[ShowUserViewController alloc] initWithUserId:[[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] intValue]];
    suVc.delegate = (id)self;
    UINavigationController *suNav=[[UINavigationController alloc] initWithRootViewController:suVc];
    suNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Account", @"TabBarTitle")
                                                     image:[UIImage imageNamed:@"droppyTabProfile.png"] 
                                                       tag:TAB_INDEX_ACCOUNT];
    suNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
#endif
    
    //タブにセット
    [array addObject:ieNav];
    //[array addObject:clNav];
    [array addObject:iuNav];
    [array addObject:seNav];
    [array addObject:suNav];

    //タイムライン検索
    [tlVc getList];
    
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

#pragma mark - Delegate

- (void)logoutDroppyTab
{
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults removeObjectForKey:@"RecommendFBAccessTokenKey"];
    [defaults removeObjectForKey:@"RecommendFBExpirationDateKey"];
    [defaults synchronize];
    
    /* バッジを削除する */
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //Twitter Oauthデータ削除
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey: @"authData"];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    //facebookログアウト
    DroppyAppDelegate *delegate = (DroppyAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] logout];
    [[delegate facebookRecommend] logout];
    
    //Droppyログアウト
    NSError *error;
    [SFHFKeychainUtils deleteItemForUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"userText"] andServiceName:@"Droppy" error:&error];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)googleSyncTab:(NSString *)userText pass:(NSString *)passText
{
    NSLog(@"Tab");
    //[clVc googleSync:userText pass:passText];
}

- (void)googleSyncTabLogin
{
    [suVc googleSyncShowUserViewLogin];
}

@end
