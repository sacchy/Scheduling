//
//  HeaderView.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#define HEADER_HEIGHT 80

typedef enum {
    HeaderViewStateHidden = 0,
    HeaderViewStatePullingDown,
    HeaderViewStateOveredThreshold,
    HeaderViewStateStopping
} HeaderViewState;

@interface HeaderView : UIView {
    
}

@property (nonatomic, retain) UILabel* textLabel;
@property (nonatomic, retain) UILabel* detailTextLabel;
@property (nonatomic, retain) UIImageView* imageView; 
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicatorView;
@property (nonatomic, assign) HeaderViewState state;

- (void)setUpdatedDate:(NSDate*)date;

@end