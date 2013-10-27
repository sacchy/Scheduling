//
//  ShowUserViewController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowViewController.h"
#import "User.h"

@interface ShowUserViewController : ShowViewController
{
    NSInteger userId_;
    User *user;
    
    UIView *headerView;
    UIImageView *iconView;
    UILabel *nameLabel;
    UILabel *introductionLabel;
}

- (id)initWithUserId:(NSInteger)userId;
+ (UIButton*)createCountButton:(NSInteger)count unitText:(NSString*)unit;
@end
