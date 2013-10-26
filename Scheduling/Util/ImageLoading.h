//
//  ImageLoading.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface ImageLoading : NSObject
{

}
@property (nonatomic,retain) UIImageView* imageView;
@property (nonatomic,retain) NSMutableDictionary* imageCache;
@property (nonatomic,retain) NSString* url;
@property (nonatomic,retain) NSMutableData* receivingData;
@property (nonatomic,retain) UIActivityIndicatorView *indicator;
@property (nonatomic,retain) Event *event;

+(void)imageLoading:(NSString*)urlStr 
          imageView:(UIImageView*)imageView 
         imageCache:(NSMutableDictionary*)imageCache 
              event:(Event *)event_;
@end
