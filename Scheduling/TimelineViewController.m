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
    self = [super initWithType:IndexEventViewControllerTypeNone user:1];
    if (self)
    {
        // イベント追加ボタン
        UIBarButtonItem *newPrivateEventButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                               target:self
                                                                                               action:@selector(newEventButtonDidPush:)];
        self.navigationItem.rightBarButtonItem = newPrivateEventButton;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)newEventButtonDidPush:(id)sender
{
//    NewDropEventViewController* newde = [[NewDropEventViewController alloc] init];
//    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:newde];
//    nav.navigationBar.barStyle = UIBarStyleBlackOpaque;
//    
//    [self presentModalViewController:nav animated:YES];
    NSLog(@"new");
}

@end
