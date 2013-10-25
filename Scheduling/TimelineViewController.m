//
//  TimelineViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "TimelineViewController.h"

@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"TimeLine", @"Title");
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
