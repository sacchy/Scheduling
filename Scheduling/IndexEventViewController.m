//
//  IndexEventViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "IndexEventViewController.h"
#import "IndexEventCell.h"
#import "Event.h"
#import "ImageLoading.h"
#import "FMDatabase.h"
#import "Logger.h"

@interface IndexEventViewController ()

@end

@implementation IndexEventViewController

- (id)initWithType:(IndexEventViewControllerType)type user:(NSInteger)userID
{
    self = [super init];
    if (self)
    {
        type_ = type;
        userId_ = userID;
        
        switch (type_)
        {
            case IndexEventViewControllerTypeNone:
                self.title = NSLocalizedString(@"Timeline", @"IndexEventViewController");
                [self getEvent];
                break;
            case IndexEventViewControllerTypeMyEvent:
                self.title = NSLocalizedString(@"CreatedEvents", @"IndexEventViewController");
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)getEvent
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    dir   = [paths objectAtIndex:0];
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"event.db"]];
    NSString *select = [NSString stringWithFormat:@"SELECT * FROM events LIMIT 0,30"];
    [db open];
    FMResultSet *results = [db executeQuery:select];
    while ([results next])
    {
        NSMutableDictionary *temp = [NSMutableDictionary dictionary];
        [temp setObject:[NSString stringWithFormat:@"%d",[results intForColumn:@"schedule_id"]] forKey:@"schedule_id"];
        [temp setObject:[NSString stringWithFormat:@"%d",[results intForColumn:@"creator_id"]] forKey:@"creator_id"];
        [temp setObject:[results stringForColumn:@"name"] forKey:@"name"];
        [temp setObject:[results stringForColumn:@"icon_path"] forKey:@"icon_path"];
        [temp setObject:[results stringForColumn:@"user_name"] forKey:@"user_name"];
        [temp setObject:[results stringForColumn:@"details"] forKey:@"details"];
        [dataArray addObject:temp];
    }
    [db close];
    
    events = [NSMutableArray array]; // 表示用
    for (NSMutableDictionary *dic in dataArray)
    {
        Event *event = [[Event alloc] initWithData:dic];
        [events addObject:event];
    }
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getEvent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [events count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:0.985 green:0.985 blue:0.985 alpha:1.0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    IndexEventCell* cell = ( IndexEventCell* )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell == nil )
    {
        cell = [[IndexEventCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }

    Event *event = [events objectAtIndex:indexPath.row];
    cell.user = event.userName;
    cell.event = event.name;
    
    if(event.iconPath)
    {
        [ImageLoading imageLoading:event.iconPath
                         imageView:cell.iconView
                        imageCache:imageCache
                             event:event
         ];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Event *event = [events objectAtIndex:indexPath.row];
        FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"event.db"]];
        NSString *select = [NSString stringWithFormat:@"DELETE FROM events WHERE schedule_id = '%d'",event.scheduleId];
        [db open];
        [db executeUpdate:select];
        [db close];
        
        [events removeObjectAtIndex: indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        
    }
    
    [self.tableView endUpdates];
}

#pragma mark - Editmode
- (void)editMode
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"")
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(leaveEdit)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.tableView setEditing:YES animated:YES];
}

- (void)leaveEdit
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", @"")
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(editMode)];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
	[self.tableView setEditing:NO animated:YES];
}
@end