//
//  ShowUserViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "ShowUserViewController.h"
#import "FMDatabase.h"
#import "SLStringUtil.h"
#import "ImageLoading.h"
#import "DisplayUtil.h"

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
        self.tableView.backgroundColor = [UIColor whiteColor];
        
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
    NSString *select = [NSString stringWithFormat:@"SELECT user_name,icon_path,COUNT(schedule_id) as count FROM events WHERE creator_id = 1 LIMIT 0,1;"];
    [db open];
    FMResultSet *results = [db executeQuery:select];
    while ([results next])
    {
        if ([results intForColumn:@"count"] < 1)
        {
            [headerView removeFromSuperview];
            continue;
        }
        
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        [temp setObject:[results stringForColumn:@"user_name"] forKey:@"user_name"];
        [temp setObject:[results stringForColumn:@"icon_path"] forKey:@"icon_path"];
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
    CGFloat height = 0;
    headerView = [[UIView alloc] initWithFrame:CGRectZero];
    UIView *userPanel = [[UIView alloc] initWithFrame:CGRectZero];

    // アイコン
    iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 48, 48)];
    if([SLStringUtil convNullToBlank:user_.iconPath].length > 0)
    {
        [ImageLoading imageLoading:user_.iconPath
                         imageView:iconView
                        imageCache:imageCache
                             event:nil];
    }
    [userPanel addSubview:iconView];
    
    // ユーザ名
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 40)];
    nameLabel.numberOfLines = 2;
    nameLabel.font = [UIFont boldSystemFontOfSize:14];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = user_.userName;
    [userPanel addSubview:nameLabel];
    
    height+=70;
    
    //プロフィール
    introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 280, 0)];
    introductionLabel.numberOfLines=0;
    introductionLabel.font = [UIFont systemFontOfSize:10];
    introductionLabel.text = [SLStringUtil convNullToBlank:@"プロフィールを入力して下さい。"];
    [DisplayUtil calcLabelHeight:introductionLabel];
    [userPanel addSubview:introductionLabel];
    
    height += introductionLabel.bounds.size.height + 10;
    
    // イベント
    UIButton *eventButton = [DisplayUtil createCountButton:user_.count
                                                  unitText:NSLocalizedString(@"イベント", @"Title")];
    [eventButton addTarget:self
                    action:@selector(eventButtonDidPush:)
          forControlEvents:UIControlEventTouchUpInside];
    eventButton.frame = CGRectMake(0, height, 100, 40);
    [userPanel addSubview:eventButton];
    
    //　フォロー
    UIButton *followingButton = [DisplayUtil createCountButton:0
                                                     unitText:NSLocalizedString(@"フォロー", @"Title")];
    [followingButton addTarget:self
                       action:@selector(followButtonDidPush:)
             forControlEvents:UIControlEventTouchUpInside];
    followingButton.frame = CGRectMake(99, height, 102, 40);
    [userPanel addSubview:followingButton];
    
    // フォロワー
    UIButton *followerButton = [DisplayUtil createCountButton:0
                                                    unitText:NSLocalizedString(@"フォロワー", @"Title")];
    [followerButton addTarget:self
                      action:@selector(followerButtonDidPush:)
            forControlEvents:UIControlEventTouchUpInside];
    followerButton.frame = CGRectMake(200, height, 100, 40);
    [userPanel addSubview:followerButton];
    
    height+=40;
    
    // サイズ調整
    userPanel.frame = CGRectMake(10, 10, 300, height);
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, height+20);
    
    // 丸角白背景影つき
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    [properties setObject:[NSNumber numberWithInt:8] forKey:@"corner"];
    [properties setObject:[UIColor whiteColor] forKey:@"bgcolor"];
    [properties setObject:[NSNumber numberWithFloat:0.3f] forKey:@"shadow"];
    [DisplayUtil setViewProperties:properties view:userPanel];
    
    CALayer* layer = userPanel.layer;
    layer.shadowOffset = CGSizeMake(0, 2.5); // 影までの距離
    layer.shadowColor = [[UIColor darkGrayColor] CGColor]; // 色
    layer.shadowOpacity = 0.8; // 濃さ
    
    [headerView addSubview:userPanel];
    self.tableView.tableHeaderView = headerView;
    [self.tableView reloadData];
}

- (void)editButtonDidPush:(id)sender
{

}

- (void)eventButtonDidPush:(id)sender
{
    
}

- (void)followButtonDidPush:(id)sender
{
    
}

- (void)followerButtonDidPush:(id)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getUserData:userId_];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
