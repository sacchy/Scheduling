//
//  IndexEventViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "IndexEventViewController.h"
#import "IndexEventCell.h"

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
    return [dataSource count];
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
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    IndexEventCell* cell = ( IndexEventCell* )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell == nil )
    {
        cell = [[IndexEventCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
#if 0
    Event *event;
    cell.user = event.userName;
    cell.event = event.name;
    cell.date = event.startDateTimeStr;
    
    if(event.iconPath)
    {
        /* アイコンを設定します */
        [ImageLoading imageLoading:event.iconPath
                         imageView:cell.iconView
                        imageCache:imageCache
                             event:event
         ];
    }
#endif
    return cell;
}
@end
