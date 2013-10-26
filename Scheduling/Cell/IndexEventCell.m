//
//  IndexEventCell.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "IndexEventCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation IndexEventCell

@synthesize icon,user,event,date,dropButton,iconView,dropImageView;

//アイコン
- (UIImage *)icon { return iconView.image; }
- (void)setIcon:(UIImage *)value { iconView.image = value;}
//ユーザー名
- (NSString *)user { return userLabel.text; }
- (void)setUser:(NSString *)value { userLabel.text = value; }
//イベント名
- (NSString *)event { return eventLabel.text; }
- (void)setEvent:(NSString *)value { eventLabel.text = value; }
//日付
- (NSString *)date { return dateLabel.text; }
- (void)setDate:(NSString *)value { dateLabel.text = value; }

-(id)init
{
    self =[super init];
    if (self) 
    {
        //背景
        self.backgroundColor = [UIColor whiteColor];
        
        //アイコン
        iconView = [[UIImageView alloc] init];
        iconView.frame=CGRectMake(3, 5, 53, 53);
        iconView.layer.borderWidth = 1;
        iconView.layer.borderColor = [[UIColor grayColor] CGColor];
        iconView.layer.cornerRadius = 12;
        iconView.clipsToBounds = true;
        [self.contentView addSubview:iconView];
        //ユーザー
        userLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 2, 170, 16)];
        userLabel.backgroundColor =[UIColor clearColor];
        userLabel.font=[UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:userLabel];
        
        //イベント
        eventLabel = [[VerticalLabel alloc] initWithFrame:CGRectMake(60, 16, 200, 44)];
        eventLabel.numberOfLines=2;
        eventLabel.backgroundColor=[UIColor clearColor];
        eventLabel.font=[UIFont systemFontOfSize:12];
        eventLabel.verticalAlignment=VerticalAlignmentTop;
        [self.contentView addSubview:eventLabel];
        
        //日付
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 2, 80, 16)];
        dateLabel.textAlignment=UITextAlignmentRight;
        dateLabel.backgroundColor=[UIColor clearColor];
        dateLabel.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:dateLabel];
        
        //ボタン
        //CustomButton* button = [CustomButton buttonWithType:UIButtonTypeCustom];

        dropButton = [CustomButton buttonWithType:UIButtonTypeCustom];
        //dropButton.backgroundColor = [UIColor redColor];
        dropButton.frame = CGRectMake(256, 0, 64, 64);
        [self.contentView addSubview:dropButton];

        //イメージ
        dropImageView =[[UIImageView alloc] initWithFrame:CGRectMake(19, 25, 13, 12)];
        [dropButton addSubview:dropImageView];
    }
    return self;
}

-(void)clear{
    iconView.hidden=YES;
    userLabel.text=[NSString string];
    eventLabel.text=[NSString string];
    dateLabel.text=[NSString string];
}

@end