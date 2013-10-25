//
//  HeaderView.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

#define HEADER_HEIGHT 60

@synthesize textLabel,detailTextLabel,imageView,activityIndicatorView;
@synthesize state = state_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.state = HeaderViewStateHidden;
        [self setUpdatedDate:nil];
        
        //矢印
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"grayArrow.png"]];
        self.imageView.frame = CGRectMake(20, 0, 23, HEADER_HEIGHT);
        [self addSubview:self.imageView];
        
        //ラベル
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 320, HEADER_HEIGHT)];
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.textLabel];
        
        //インジケーター
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicatorView.center=CGPointMake(50, 30);
        [self addSubview:self.activityIndicatorView];
        
        // 更新日時
        self.detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, 320, HEADER_HEIGHT)];
        self.detailTextLabel.font = [UIFont boldSystemFontOfSize:12];
        self.detailTextLabel.textColor = [UIColor darkGrayColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.detailTextLabel];
    }
    
    return self;
}

- (void)_animateImageForHeadingUp:(BOOL)headingUp
{
    CGFloat startAngle = headingUp ? 0 : M_PI + 0.00001;
    CGFloat endAngle = headingUp ? M_PI + 0.00001 : 0;
    
    self.imageView.transform = CGAffineTransformMakeRotation(startAngle);           
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.imageView.transform =
                         CGAffineTransformMakeRotation(endAngle);
                         
                     }
                     completion:NULL
     ];
}

- (void)setState:(HeaderViewState)state
{
    switch (state)
    {
        case HeaderViewStateHidden:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = YES;
            break;
            
        case HeaderViewStatePullingDown:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = NO;
            self.textLabel.text = @"画面を引き下げて...";
            if (state_ != HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:NO];
            }
            break;
            
        case HeaderViewStateOveredThreshold:
            [self.activityIndicatorView stopAnimating];
            self.imageView.hidden = NO;
            self.textLabel.text = @"指をはなすと更新";
            if (state_ == HeaderViewStatePullingDown) {
                [self _animateImageForHeadingUp:YES];
            }
            break;
            
        case HeaderViewStateStopping:
//            [self.activityIndicatorView startAnimating];
            self.textLabel.text = @"更新中...";
            self.imageView.hidden = YES;
            break;
    }
    
    state_ = state;
}


#pragma mark -
#pragma mark API

- (void)setUpdatedDate:(NSDate*)date
{
    NSString* dateString = [date description];
    if (date == nil) {
        dateString = @"-";
    }
    self.detailTextLabel.text = [NSString stringWithFormat:@"最後の更新: %@", dateString];
}

@end
