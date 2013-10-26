//
//  ImageLoading.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "ImageLoading.h"

@implementation ImageLoading
static NSMutableDictionary* imageCacheData;

@synthesize imageView = imageView_;
@synthesize imageCache = imageCache_;
@synthesize url = url_;
@synthesize receivingData = receivingData_;
@synthesize indicator = indicator_;
@synthesize event = event_;

+(void)imageLoading:(NSString*)urlStr 
          imageView:(UIImageView*)imageView
         imageCache:(NSMutableDictionary*)imageCache
               event:(Event*)event_
{
    //一度ダウンロードした画像をダウンロードしないように
    //Dictionaryに保存されたキャッシュをチェック
    if ([imageCache objectForKey:urlStr]!=nil)
    {
        //キャッシュにヒットした場合はその画像を使用する
        imageView.image = [imageCache objectForKey:urlStr];
#if 0        
        if(event_ != nil && ![event_ isKindOfClass:[NSNull class]])
        {
            SLSQLite *sqlite = [[SLSQLite alloc] init];
            [sqlite open];
            [sqlite begin];
            
            EventController *ev = [[EventController alloc] initWidhDB:sqlite];
            
            /* NSData to NSString */
            event_.icon_data = [Crypto base64StringFromData:[imageCacheData objectForKey:urlStr] :[[imageCacheData objectForKey:urlStr] length]];
            
            BOOL result = [ev save:event_];
            if(!result)
            {
                NSLog(@"rollback");
                [sqlite rollback];
            }      
            [sqlite commit];
            [sqlite close];      
            
            NSLog(@"%@",event_.userName);
            NSLog(@"書き込みできました");
        }
#endif
        
        return;
    }
    //画像を新スレッドでダウンロードする準備、このクラスをインスタンス化
    ImageLoading* this = [[ImageLoading alloc] init];
    this.imageView = imageView;
    this.imageCache = imageCache;
    this.url = urlStr;
    this.event = event_;
    
    NSURL *url = [NSURL URLWithString: urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //非同期リクエストを発行し、このクラスのインスタンスでコールバックを受ける
    [NSURLConnection connectionWithRequest:request delegate:this];
    //インジケーター
    this.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    this.indicator.center = CGPointMake(this.imageView.bounds.size.width/2, this.imageView.bounds.size.height/2);
    [this.indicator startAnimating];
    [this.imageView addSubview:this.indicator];
}
//データが受信開始されたときに呼び出される
-(void) connection:(NSURLConnection *) connection 
didReceiveResponse:(NSURLResponse *) response {
    self.receivingData = [[NSMutableData alloc] init];
}
//データが受信中に呼び出される
-(void) connection:(NSURLConnection *) connection 
    didReceiveData:(NSData *) data {
    [self.receivingData appendData:data];
}
//画像を読み終わった後に呼び出される
//ダウンロードしたデータからUIImageを生成し、UIImageViewに設定する
-(void) connectionDidFinishLoading:(NSURLConnection *) connection 
{
    [self.indicator removeFromSuperview];
    
    if (self.receivingData==nil || [self.receivingData length] == 0)
    {
        return;
    }
    
    UIImage* image = [UIImage imageWithData: self.receivingData];
        
    if (image != nil) 
    {
        self.imageView.image = image;
        [self.imageView.superview sizeToFit];
        [self.imageCache setObject:image forKey:self.url];
        [imageCacheData setObject:self.receivingData forKey:self.url];
#if 0
        if(event_ != nil && ![event_ isKindOfClass:[NSNull class]])
        {
            SLSQLite *sqlite = [[SLSQLite alloc] init];
            [sqlite open];
            [sqlite begin];
        
            EventController *ev = [[EventController alloc] initWidhDB:sqlite];
                        
            /* NSData to NSString */
            event_.icon_data = [Crypto base64StringFromData:self.receivingData :[self.receivingData length]];

            BOOL result = [ev save:event_];
            if(!result)
            {
                NSLog(@"rollback");
                [sqlite rollback];
            }      
            [sqlite commit];
            [sqlite close];      
            
            NSLog(@"%@",event_.userName);
            NSLog(@"書き込みできました");
        }
        else
        {
            //UserController *us = [[UserController alloc] initWidhDB:sqlite];
            //User *user_model = [[User alloc] initWithData:element];
        }
#endif
    }
}

@end