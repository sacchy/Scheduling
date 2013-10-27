//
//  IndexViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "IndexViewController.h"
#import "AppMacro.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

@synthesize headerView;
@synthesize footerView;

#pragma mark -
#pragma mark Initialization

- (id)init
{
    self   = [super init];
    if (self) 
    {
        // 変数等初期化
        loadOffset = 0;
        imageCache = [NSMutableDictionary dictionary];
        
        // Set TableView
        self.tableView.backgroundColor = [UIColor colorWithRed:0.765 green:0.765 blue:0.765 alpha:1.0];
        
        self.headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, HEADER_HEIGHT)];
        self.footerView = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        
        self.tableView.tableHeaderView = self.headerView;
        //self.tableView.tableFooterView = self.footerView;
        
        [self setHeaderViewHidden:YES animated:NO];
    }
    return self;
}


#pragma mark -
#pragma mark Private Method

//ヘッダを隠す
- (void)setHeaderViewHidden:(BOOL)hidden animated:(BOOL)animated
{
    NSLog(@"hidden");
    CGFloat topOffset = 0.0;
    if (hidden)
    {
        topOffset = -self.headerView.frame.size.height ;
    }
    if (animated)
    {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
                         }];
    }
    else
    {
        self.tableView.contentInset = UIEdgeInsetsMake(topOffset, 0, 0, 0);
    }
}

//プルダウンのリロード終了時
- (void)reloadFinishedHeader
{
    self.headerView.state = HeaderViewStateHidden;
    
    // 日時更新
    [self.headerView setUpdatedDate:[NSDate date]];
    
//    [self setHeaderViewHidden:YES animated:YES];
}

- (void)reloadFinishedFooter
{
    self.footerView.state = FooterViewStateHidden;
}

#pragma mark -
#pragma mark HttpRequest

//イベント取得
- (void)getList
{
    NSLog(@"getList");
    [self reloadFinishedHeader];
//    [self reloadFinishedFooter];
}

// 追加データ取得
- (void)getListLoadMore
{
    NSLog(@"getListLoadMore");
}

// コールバック
- (void)callback:(NSMutableDictionary *)data
{
    [indicator removeFromSuperview];
    sending = NO;
    self.view.userInteractionEnabled=YES;
}

#pragma mark -
#pragma mark UIScrollViewDelegate

//スクロール時
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.bounds;
    CGSize size = scrollView.contentSize;
    UIEdgeInsets inset = scrollView.contentInset;
    
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    CGFloat threshold = self.headerView.frame.size.height;
    
    if (self.headerView.state != HeaderViewStateStopping) 
    {
        if (PULLDOWN_MARGIN <= scrollView.contentOffset.y && scrollView.contentOffset.y < threshold)
        {
            self.headerView.state = HeaderViewStatePullingDown;
        }
        else if (scrollView.contentOffset.y < PULLDOWN_MARGIN)
        {
            self.headerView.state = HeaderViewStateOveredThreshold;
        }
        else
        {
            self.headerView.state = HeaderViewStateHidden;
        }
    }
    
    if((y > h + PULLUP_MARGIN) && self.footerView.state != FooterViewStateReloding)
    {
        self.footerView.state = FooterViewStateReloding;
     
        //追加ロード
        [self performSelector:@selector(getListLoadMore)];
    }
}

//ドラッグ終了時
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.headerView.state == HeaderViewStateOveredThreshold)
    {
        self.headerView.state = HeaderViewStateStopping;
//        [self setHeaderViewHidden:NO animated:YES];
        [self performSelector:@selector(getList)];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    
    UITableViewCell* cell = ( UITableViewCell* )[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if( cell == nil )
    {
        cell = [[UITableViewCell alloc] init];
    }
    
    return cell;
}

#pragma mark - 
#pragma mark View lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
