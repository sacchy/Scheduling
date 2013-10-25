//
//  FooterView.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FooterViewStateHidden = 0,
    FooterViewStateReloding
} FooterViewState;

@interface FooterView : UIView{
    
}
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicatorView;
@property (nonatomic, assign) FooterViewState state;

@end
