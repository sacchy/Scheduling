//
//  RootViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "RootViewController.h"
#import "AppMacro.h"

@implementation RootViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //タップイベントを検知
    self.view.userInteractionEnabled = NO;
    
    UIImage *splashImage;
    if([[UIScreen mainScreen]bounds].size.height == 568)
        splashImage = [UIImage imageNamed:@"Default-h568.png"];
    else
        splashImage = [UIImage imageNamed:@"Default.png"];

    UIImageView *splashImageView = [[UIImageView alloc] initWithImage:splashImage];
    splashImageView.frame = CGRectMake(0, 0, WIN_SIZE.width, WIN_SIZE.height);
    [self.view addSubview:splashImageView];

    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelay:2.0f];   
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(buttonEnable)];
    
    splashImageView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)buttonEnable
{
    [[[self.view subviews] lastObject] removeFromSuperview];
    
    //タップイベントを検知
    self.view.userInteractionEnabled = YES;
    
    TabMainController *tabMainController = [[TabMainController alloc] init];
    UINavigationController *tabNav = [[UINavigationController alloc] initWithRootViewController:tabMainController];
    [self.navigationController pushViewController:tabNav animated:YES];
}

@end
