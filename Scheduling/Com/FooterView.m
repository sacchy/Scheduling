//
//  FooterView.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "FooterView.h"

@implementation FooterView
@synthesize activityIndicatorView;
@synthesize state = state_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //インジケーター
        self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        [self addSubview:self.activityIndicatorView];
    }
    return self;
}

- (void)setState:(FooterViewState)state
{
    switch (state)
    {
        case FooterViewStateHidden:
            [self.activityIndicatorView stopAnimating];
            break;
            
        case FooterViewStateReloding:
            [self.activityIndicatorView startAnimating];
            break;
        default:
            break;
    }
    
    state_ = state;
}


@end
