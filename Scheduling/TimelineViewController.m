//
//  TimelineViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "TimelineViewController.h"
#import "NewDropEventViewController.h"
#import "FMDatabase.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (id)init
{
    self = [super initWithType:IndexEventViewControllerTypeNone user:1];
    if (self)
    {
        // イベント追加ボタン
        UIBarButtonItem *newPrivateEventButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(newEventButtonDidPush:)];
        self.navigationItem.rightBarButtonItem = newPrivateEventButton;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // FMDB初期設定
    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    dir   = [paths objectAtIndex:0];
    NSLog(@"%@",paths);
    
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"event.db"]];
    NSString *sql = @"CREATE TABLE IF NOT EXISTS events (schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,creator_id INTEGER,name TEXT,icon_path TEXT,user_name TEXT,details TEXT);";

    [db open];
    [db executeUpdate:sql];
    [db close];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)newEventButtonDidPush:(id)sender
{    
    NewDropEventViewController *newEvent = [[NewDropEventViewController alloc] init];
    UINavigationController *newNav = [[UINavigationController alloc] initWithRootViewController:newEvent];
    newNav.navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self presentViewController:newNav animated:YES completion:nil];
}

@end
