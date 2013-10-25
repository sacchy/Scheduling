//
//  NewDropEventViewController.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewDropEventViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextView *tv;
    UIToolbar *toolbar;
    CGRect _textViewFrameSaved;
    UIView *toolbarView;
    UIView *subtoolbarView;
    UIView *subsubtoolbarView;
    UITableView *rangeTableView;
    NSMutableArray *item;
    UIButton *invisibleButton;
    int offset;
    UIDatePicker *dateSlot;
    CGRect slotframe;
    UITextField *textFieldEvent;
    UITextField *textFieldPlace;
    bool detailSeg;
    
    NSInteger           loginUserId;        //ログインユーザーID
}

- (void)shareRange;
- (void)openKeyboard;
- (void)dateSelect;
- (void)addDetail;
- (CGRect)keyboardRectByNotification:(NSNotification*)note userInfoKey:(NSString*)key orientation:(UIInterfaceOrientation)orientation;
@end
