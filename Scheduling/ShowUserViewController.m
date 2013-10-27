//
//  ShowUserViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "ShowUserViewController.h"
#import "FMDatabase.h"
#import "Logger.h"

@interface ShowUserViewController ()

@end

@implementation ShowUserViewController

- (id)initWithUserId:(NSInteger)userId
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.title = NSLocalizedString(@"User", @"Title");
        self.tableView.backgroundColor =[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1.0];
        
        userId_ = userId;
        
        if (userId == 1)
        {
            UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", @"UIBarButtonTitle")
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(editButtonDidPush:)];
            self.navigationItem.rightBarButtonItem = editButton;
        }
        
        [self getUserData:userId];
    }
    return self;
}

- (void)getUserData:(NSInteger)userId
{
    NSMutableArray *dataArray = [NSMutableArray array];

    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    dir   = [paths objectAtIndex:0];
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"event.db"]];
    NSString *select = [NSString stringWithFormat:@"SELECT user_name,COUNT(schedule_id) as count FROM events WHERE creator_id = 1;"];
    [db open];
    FMResultSet *results = [db executeQuery:select];
    while ([results next])
    {
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        [temp setObject:[results stringForColumn:@"user_name"] forKey:@"user_name"];
        [temp setObject:[NSString stringWithFormat:@"%d",[results intForColumn:@"count"]] forKey:@"count"];
        [dataArray addObject:temp];
    }
    [db close];
    
    for (NSMutableDictionary *dic in dataArray)
    {
        user = [[User alloc] initWithData:dic];
        [self showUserData:user];
    }
}

- (void)showUserData:(User*)user_
{
    
    [self.tableView reloadData];
}

- (void)editButtonDidPush:(id)sender
{

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
