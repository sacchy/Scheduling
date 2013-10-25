//
//  RootViewController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabMainController.h"

@interface RootViewController :UIViewController

@property (strong, nonatomic) TabMainController *tabMainController;

- (void)buttonEnable;
- (id)initWithFrame:(CGRect)frame;
@end
