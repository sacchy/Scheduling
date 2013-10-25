//
//  IndexEventCell.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "VerticalLabel.h"
#import "CustomButton.h"

#define IECELL_HEIGHT 64

@interface IndexEventCell : UITableViewCell {
@private
    UILabel         *userLabel;    // スケジュール名ラベル
    VerticalLabel   *eventLabel;   // イベント名ラベル
    UILabel         *dateLabel;    // 日付ラベル
}

@property (nonatomic, copy)   UIImage     *icon;
@property (nonatomic, copy)   NSString    *user;
@property (nonatomic, copy)   NSString    *event;
@property (nonatomic, copy)   NSString    *date;
@property (nonatomic, copy)   CustomButton *dropButton;
@property (nonatomic, copy)   UIImageView *dropImageView;
@property (nonatomic, copy)   UIImageView *iconView;

-(void)clear;

@end