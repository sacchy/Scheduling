//
//  ShowViewController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/27.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowViewController : UITableViewController
{
    // FMDB
    NSArray *paths;
    NSString *dir;
    
    NSMutableDictionary *imageCache;
}
@end
