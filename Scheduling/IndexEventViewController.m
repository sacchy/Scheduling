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
    NSLog(@"getEvent");
    
    // 通常はDBを利用
    NSMutableArray *dataArray = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"ハリーポッター上映日" forKey:@"name"];
    [dic setObject:@"1" forKey:@"schedule_id"];
    [dic setObject:@"1" forKey:@"creator_id"];
    [dic setObject:@"http://a3.mzstatic.com/us/r1000/012/Purple4/v4/56/d7/0e/56d70e8a-2df7-ba5a-8a32-c8926abc976d/mzl.udlwkxfs.175x175-75.jpg" forKey:@"icon_path"];
    [dic setObject:@"sacchy" forKey:@"user_name"];
    [dic setObject:@"半純血のプリンス" forKey:@"details"];
    [dataArray addObject:dic];
    
    events = [NSMutableArray array]; // 表示用
    for(NSMutableDictionary *dic in dataArray)
    {
        Event *event = [[Event alloc] initWithData:dic];
        [events addObject:event];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// スワイプでDeleteボタンが表示されないようにする
	return UITableViewCellEditingStyleNone ;
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
@end
