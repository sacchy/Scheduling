//
//  VerticalLabel.m
//  Scheduling
//
//  Created by Sacchy on 2013/10/25.
//  Copyright (c) 2013年 sacchy. All rights reserved.
//

#import "VerticalLabel.h"

@implementation VerticalLabel

@synthesize verticalAlignment,underlined;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.verticalAlignment = VerticalAlignmentMiddle;
        underlined=NO;
    }
    return self;
}

#pragma mark - Override DrawMethod

- (void)drawRect:(CGRect)rect {
    if (underlined) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        const CGFloat* colors = CGColorGetComponents(self.textColor.CGColor);
        
        CGContextSetRGBStrokeColor(ctx, colors[0], colors[1], colors[2], 1.0); // RGBA
        
        CGContextSetLineWidth(ctx, self.font.pointSize/30);
        
        //boldチェック
        NSRange searchResult = [self.font.fontName rangeOfString:@"Bold"];
        if(searchResult.location != NSNotFound){
            CGContextSetLineWidth(ctx, self.font.pointSize/15);
        }

        CGSize tmpSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(2000, 2000)];
        
        CGFloat lineXSt=0;
        CGFloat lineXEd=0;
        CGFloat lineY=0;
        
        switch (self.textAlignment) {
            case UITextAlignmentLeft:
                lineXEd=tmpSize.width;
                break;
            case UITextAlignmentCenter:
                lineXSt = self.bounds.size.width/2-tmpSize.width/2;
                lineXEd= lineXSt+tmpSize.width;
                break;
            case UITextAlignmentRight:
                lineXSt = self.bounds.size.width-tmpSize.width;
                lineXEd= self.bounds.size.width;
                break;
            default:
                break;
        }
        
        switch (self.verticalAlignment) {
            case VerticalAlignmentTop:
                lineY=tmpSize.height;
                break;
            case VerticalAlignmentBottom:
                lineY=self.bounds.size.height;
                break;
            case VerticalAlignmentMiddle:
                // Fall through.
            default:
                lineY=self.bounds.size.height/2+tmpSize.height/2;
                break;
        }
        
        CGContextMoveToPoint(ctx, lineXSt, lineY);
        CGContextAddLineToPoint(ctx, lineXEd, lineY);
        
        CGContextStrokePath(ctx);
    }
    
    [super drawRect:rect];  
}


- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment_ {
    verticalAlignment = verticalAlignment_;
    [self setNeedsDisplay];
}


- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
