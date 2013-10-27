//
//  DisplayUtil.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/27.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "DisplayUtil.h"

@implementation DisplayUtil

+ (void)calcLabelHeight:(UILabel*)label
{
    CGFloat ret = label.bounds.size.height;

    //テキストの高さを広げる
    CGSize size = CGSizeMake(label.bounds.size.width, 1000);
    CGSize textSize = [label.text sizeWithFont:label.font
                             constrainedToSize:size
                                 lineBreakMode:NSLineBreakByCharWrapping];
    float h = textSize.height - label.bounds.size.height;
    if (h > 0)
    {
        ret+=h;
    }
    
    label.frame = CGRectMake(label.frame.origin.x
                             , label.frame.origin.y
                             , label.frame.size.width
                             , ret);
}

+ (UIButton*)createCountButton:(NSInteger)count unitText:(NSString*)unit
{
    // スケジュール数
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderWidth=.5f;
    button.layer.borderColor=[[UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1.0] CGColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(20, -60, 5, 0)]; // top left bottom right
    
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setFormatterBehavior: NSNumberFormatterBehavior10_4 ];
    [fmt setNumberStyle: NSNumberFormatterDecimalStyle];
    [button setTitle:[fmt stringFromNumber:[NSNumber numberWithInt:count]] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    
    // ラベル
    UILabel *unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 16)];
    unitLabel.text=unit;
    unitLabel.font=[UIFont systemFontOfSize:10];
    unitLabel.textColor = [UIColor grayColor];
    unitLabel.backgroundColor=[UIColor clearColor];
    [button addSubview:unitLabel];
    
    return button;
}

// ビューのプロパティを設定
+ (void)setViewProperties:(NSMutableDictionary*)properties view:(UIView *)view
{
    //背景色
    if ([properties objectForKey:@"bgcolor"])
    {
        view.backgroundColor = [properties objectForKey:@"bgcolor"];
    }
    //丸角
    if ([properties objectForKey:@"corner"])
    {
        view.layer.borderWidth = 1;
        view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        view.layer.cornerRadius = [[properties objectForKey:@"corner"] intValue];
    }
    //影
    if ([properties objectForKey:@"shadow"])
    {
        view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.layer.cornerRadius].CGPath;
        view.layer.shadowOpacity = [[properties objectForKey:@"shadow"] floatValue];
    }
}
@end
