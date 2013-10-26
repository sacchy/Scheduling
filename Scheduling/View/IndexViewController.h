//
//  IndexViewController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "HeaderView.h"
#import "FooterView.h"

//#import "Logger.h"
//#import "DisplayUtil.h"

#define LIMIT_DATA_ROWS 20
#define PULLDOWN_MARGIN -15.0f
#define PULLUP_MARGIN 15.0f

@interface IndexViewController : UITableViewController
{
@protected

    UIView              *indicator;
    BOOL                sending;
    NSInteger           loadOffset;         //データオフセット
    NSMutableDictionary *imageCache;        //アイコンデータキャッシュ
    
    // データ表示用
    NSMutableArray *events;
    
    // FMDB
    NSArray *paths;
    NSString *dir;
}
@property (nonatomic, retain) HeaderView* headerView;
@property (nonatomic, retain) FooterView* footerView;

- (void)setHeaderViewHidden:(BOOL)hidden animated:(BOOL)animated;
- (void)reloadFinishedHeader;
- (void)reloadFinishedFooter;

@end