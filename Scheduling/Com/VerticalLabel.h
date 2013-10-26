//
//  VerticalLabel.h
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticalLabel : UILabel
{
    VerticalAlignment verticalAlignment;
    BOOL underlined;
}
@property(nonatomic, assign) VerticalAlignment verticalAlignment;
@property(nonatomic, assign) BOOL underlined;
@end
