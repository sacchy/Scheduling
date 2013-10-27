//
//  NewDropEventViewController.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AppMacro.h"
#import "NewDropEventViewController.h"
#import "Event.h"
#import "SLDateUtil.h"
#import "FMDatabase.h"
#define RANGE 0

@implementation NewDropEventViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //初期化
    detailSeg = NO;
    
    //テキストフィールド
    textFieldEvent = [[UITextField alloc]initWithFrame:CGRectMake(20, WIN_SIZE.height*0.15, 280, 30)];
    textFieldEvent.keyboardType = UIKeyboardTypeDefault;
    textFieldEvent.borderStyle = UITextBorderStyleRoundedRect;
    textFieldEvent.placeholder = @"イベント名を入力して下さい";
    textFieldEvent.delegate = self;
    textFieldEvent.enablesReturnKeyAutomatically = YES; //文字がないと完了できないようにする
    textFieldEvent.adjustsFontSizeToFitWidth = YES;
    textFieldEvent.returnKeyType = UIReturnKeyDone;
    textFieldEvent.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFieldEvent.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:textFieldEvent];
    [textFieldEvent becomeFirstResponder];
    
    //テキストビュー
    tv = [[UITextView alloc] initWithFrame:CGRectMake(20, WIN_SIZE.height*0.25, 280, WIN_SIZE.height*0.2)];
    tv.font = [UIFont systemFontOfSize:16];
    tv.returnKeyType = UIReturnKeyDefault;
    [tv setAutocorrectionType:UITextAutocorrectionTypeNo];
    [tv setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [tv setKeyboardType:UIKeyboardTypeDefault];
    tv.layer.borderWidth = 1;
    tv.layer.borderColor = [[UIColor grayColor] CGColor];
    tv.layer.cornerRadius = 8;
    
    //ツールバー背景
    subtoolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, 320, 480)];
    subtoolbarView.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:229.0/255.0 blue:234.0/255.0 alpha:1.0];
    [self.view addSubview:subtoolbarView];
    
    toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 160+2, 320, 480)];//(0, 163, 320, 5)];
    toolbarView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    [self.view addSubview:toolbarView];
    
    //日付
    dateSlot = [[UIDatePicker alloc] init];
    slotframe = dateSlot.frame;
    slotframe.origin.y = 480;
    dateSlot.frame = slotframe;
    //dateSlot.center = self.view.center;
    dateSlot.minuteInterval = 1;
    dateSlot.datePickerMode = UIDatePickerModeDateAndTime;
    dateSlot.date = [NSDate date];
    [self.view addSubview:dateSlot];
    
    //ツールバー
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 480, 320, 44)];
    toolbar.barStyle = UIBarStyleBlack;
    //toolbar.translucent = YES;
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"決定" 
                                                                 style:UIBarButtonItemStyleDone
                                                                target:self
                                                                action:@selector(openKeyboard)]; 
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"キャンセル" 
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(openKeyboard)]; 
    
    NSArray *buttonItems = [NSArray arrayWithObjects:
                            cancelItem,
                            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                          target:nil
                                                                          action:nil],
                            doneItem, nil];
    [toolbar setItems:buttonItems animated:NO];
    [self.view addSubview:toolbar];
    
    //ツールバー
    UIButton *slotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    slotButton.frame = CGRectMake(0, 0, 50, 40);
    [slotButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [slotButton setTitle:@"日にち" forState:UIControlStateNormal];
    [slotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //有効時
    [slotButton addTarget:self action:@selector(dateSelect)forControlEvents:UIControlEventTouchUpInside];  
    [toolbarView addSubview:slotButton];
    
    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    detailButton.frame = CGRectMake(140, 0, 50, 40);
    [detailButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [detailButton setTitle:@"詳細" forState:UIControlStateNormal];
    [detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //有効時
    [detailButton addTarget:self action:@selector(addDetail)forControlEvents:UIControlEventTouchUpInside];  
    [toolbarView addSubview:detailButton];
    
    UIButton *rangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rangeButton.frame = CGRectMake(270, 0, 50, 40);
    [rangeButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [rangeButton setTitle:@"公開範囲" forState:UIControlStateNormal];
    [rangeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal]; //有効時
    [rangeButton addTarget:self action:@selector(shareRange)forControlEvents:UIControlEventTouchUpInside];  
    [toolbarView addSubview:rangeButton];
    
    //テーブル
    item = [NSMutableArray arrayWithObjects:@"公開", @"限定", @"自分のみ", nil];
    rangeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, WIN_SIZE.height, 320 , 480) style:UITableViewStylePlain];
    rangeTableView.delegate = self;
    rangeTableView.dataSource = self;
    rangeTableView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0];
    [self.view addSubview:rangeTableView]; 
    
    // キーボード表示関連の通知を受け取るようにします。
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"新しいイベント";
    [textFieldEvent becomeFirstResponder];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    titleLabel.numberOfLines=2;
    titleLabel.font=[UIFont boldSystemFontOfSize:18];
    titleLabel.backgroundColor =[UIColor clearColor];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.text = self.title;
    self.navigationItem.titleView=titleLabel;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"cancelButton")
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self 
                                                                    action:@selector(cancelButtonDidPush:)];
    self.navigationItem.leftBarButtonItem =cancelButton;    
    
    //保存ボタン
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(saveButtonDidPush:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableView DataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [item count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

//セクションタイトル (ここはヘッダーのスペースを確保するだけ)
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch(section) 
    {
        case RANGE:
            return @"公開範囲";
            break;
    }
    return nil; //ビルド警告回避用
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        //セルを選択した時
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        //初期チェックマーク
        if(indexPath.row == 0)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[item objectAtIndex:indexPath.row]];
    
    return cell;
}

//セルが選択されたときの処理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; //必須メソッド
    
    int temp;
    UITableViewCell* cell = nil;

    cell = [tableView cellForRowAtIndexPath:indexPath];
    temp = indexPath.row;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    for (int i=0; i < [item count]; i++) {
        
        if (temp != i){
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    
    [self openKeyboard];
}

#pragma mark - TexiField
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

#pragma mark - Button

- (void)shareRange
{
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invisibleButton.backgroundColor = [UIColor clearColor];
    invisibleButton.frame = CGRectMake(0, 0, 320, 160+offset);
    [invisibleButton setTitle:@"" forState:UIControlStateDisabled];
    [invisibleButton addTarget:self action:@selector(openKeyboard)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:invisibleButton];
    
    // アニメーションを開始します。
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [textFieldEvent resignFirstResponder];
    [tv resignFirstResponder];
    rangeTableView.frame = CGRectMake(0, 160+offset, 320, 480);
    
    // アニメーションを確定します。
    [UIView commitAnimations];

}

- (void)openKeyboard
{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    [invisibleButton removeFromSuperview];
    
    // アニメーションを開始します。
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [textFieldEvent becomeFirstResponder];
    rangeTableView.frame = CGRectMake(0, WIN_SIZE.height, 320, 480);
    toolbar.frame = CGRectMake(0, WIN_SIZE.height, 320, 44);
    
    slotframe = dateSlot.frame;
    slotframe.origin.y = 480;
    dateSlot.frame = slotframe;
    
    // アニメーションを確定します。
    [UIView commitAnimations];
}

- (void)dateSelect
{
    self.navigationItem.leftBarButtonItem.enabled = NO;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    invisibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    invisibleButton.backgroundColor = [UIColor clearColor];
    invisibleButton.frame = CGRectMake(0, 0, 320, 160+offset);
    [invisibleButton setTitle:@"" forState:UIControlStateDisabled];
    [invisibleButton addTarget:self action:@selector(openKeyboard)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:invisibleButton];
    
    // アニメーションを開始します。
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [textFieldEvent resignFirstResponder];
    [tv resignFirstResponder];
    
    toolbar.frame = CGRectMake(0, 160+offset, 320, 44);
    
    slotframe = dateSlot.frame;
    slotframe.origin.y = 160+44+offset;
    dateSlot.frame = slotframe;
    
    // アニメーションを確定します。
    [UIView commitAnimations];    
}

- (void)addDetail
{
    [textFieldEvent resignFirstResponder];

    if(detailSeg)
    {
        detailSeg = NO;
        [tv removeFromSuperview];
        [textFieldEvent becomeFirstResponder];
    }
    else
    {
        detailSeg = YES;
        [self.view insertSubview:tv atIndex:2];
        [self.view addSubview:tv];
        [tv becomeFirstResponder];
    }
}

- (void)cancelButtonDidPush:(id)sender
{
    //修正の場合
    [self.navigationController popViewControllerAnimated:YES];
    
    //新規の場合
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveButtonDidPush:(id)sender
{
    if ([textFieldEvent.text length] < 1)
    {
        [self showAlert];
        return;
    }
    
    // FMDB
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"event.db"]];
    [db open];
    [db close];
    
    NSString *sql = @"REPLACE INTO events (creator_id,name,icon_path,user_name,details) VALUES (?,?,?,?,?);";
    
    [db open];
    [db executeUpdate:sql,[NSString stringWithFormat:@"%d",1],textFieldEvent.text,@"http://a3.mzstatic.com/us/r1000/012/Purple4/v4/56/d7/0e/56d70e8a-2df7-ba5a-8a32-c8926abc976d/mzl.udlwkxfs.175x175-75.jpg",@"Sacchy",tv.text];
    [db close];
    
    //修正の場合
    [self.navigationController popViewControllerAnimated:YES];
    
    //新規の場合
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)keyboardDidShow:(NSNotification*)notification
{
    //キーボードのフレームを取得
    NSDictionary *info = [notification userInfo];
    NSValue *keyValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [keyValue CGRectValue].size;
    
    //自分のViewの高さからキーボードとツールバーの高さを引く。(ツールバーのY軸位置)
    NSInteger toolbarY = self.view.frame.size.height - keyboardSize.height - 54;
    
    //最後にツールバーを移動してあげて完了
    subtoolbarView.frame = CGRectMake(0, toolbarY+14, 320, 480);
    toolbarView.frame = CGRectMake(0, toolbarY+16, 320, 480);
    offset = toolbarY-145;
}

// UIKeyboardDidHideNotification 通知が来たら実行するように登録したメソッドです。
- (void)keyboardDidHide:(NSNotification*)note
{
    // キーボードが表示中（元のサイズが保存されている）場合に復元処理を行います。
    if (!CGRectIsEmpty(_textViewFrameSaved))
    {
        NSLog(@"HIDE実行");
        
        // UITextView をアニメーションでサイズ変更するために、キーボードの表示アニメーション時間を取得します。
        NSTimeInterval duration = [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        // アニメーションを開始します。
        [UIView beginAnimations:@"restoreTextViewFrame" context:nil];
        [UIView setAnimationDuration:duration];
        
        // UITextView のサイズを復元します。
        //tv.frame = _textViewFrameSaved;
        
        // アニメーションを確定します。
        [UIView commitAnimations];
        
        // 保存しておいた UITextView の元のサイズをリセットします。
        _textViewFrameSaved = CGRectZero;
        
    }
}

- (CGRect)keyboardRectByNotification:(NSNotification*)note userInfoKey:(NSString*)key orientation:(UIInterfaceOrientation)orientation
{
    CGRect result;
    
    CGRect keyboardFrame = [[[note userInfo] objectForKey:key] CGRectValue];
    CGRect keyWindowFrame = [[[UIApplication sharedApplication] keyWindow] frame];
    
    CGFloat keyWidth = CGRectGetWidth(keyWindowFrame) - CGRectGetWidth(keyboardFrame);
    CGFloat keyHeight = CGRectGetHeight(keyWindowFrame) - CGRectGetHeight(keyboardFrame);
    
    // キーボードの座標系をビューの座標系に変換します。
    switch (orientation)
    {
        case UIInterfaceOrientationPortrait:
            result = keyboardFrame;
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            result.origin.x = keyboardFrame.origin.x;
            result.origin.y = keyHeight - keyboardFrame.origin.y;
            result.size = keyboardFrame.size;
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            result.origin.x = keyboardFrame.origin.y;
            result.origin.y = keyboardFrame.origin.x;
            result.size.width = keyboardFrame.size.height;
            result.size.height = keyboardFrame.size.width;
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            result.origin.x = keyboardFrame.origin.y;
            result.origin.y = keyWidth - keyboardFrame.origin.x;
            result.size.width = keyboardFrame.size.height;
            result.size.height = keyboardFrame.size.width;
            break;
    }
    
    return result;
}

#pragma mark - Alert
- (void)showAlert
{
    UIAlertView *registAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Cation", @"")
                                                          message:NSLocalizedString(@"PleaseEnter", @"")
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil, nil];
    [registAlert show];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            break;
        default:
            break;
    }
}
@end
