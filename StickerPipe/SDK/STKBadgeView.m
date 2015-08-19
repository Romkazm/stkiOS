//
//  STKBadgeVIew.m
//  StickerPipe
//
//  Created by Vadim Degterev on 13.08.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKBadgeView.h"


@implementation STKBadgeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGFloat lineWidth = 1.5;
    CGRect rectInsets = CGRectInset(rect,lineWidth,lineWidth);
    UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:rectInsets cornerRadius:CGRectGetHeight(rectInsets) / 2.0];
    [[UIColor redColor] setFill];
    [path fill];
    path.lineWidth = lineWidth;
    [[UIColor whiteColor] setStroke];
    [path stroke];
    
    CGFloat whiteDotWight = 3.0;
    CGFloat whiteDotHeight = 3.0;
    CGFloat whiteDotY = CGRectGetMidY(rectInsets) - (whiteDotHeight / 2.0);
    CGFloat whiteDotX = CGRectGetMidX(rectInsets) - (whiteDotWight / 2.0);
    
    UIBezierPath *whiteDot = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(whiteDotX, whiteDotY, whiteDotWight, whiteDotHeight) cornerRadius:whiteDotHeight / 2.0];
    [[UIColor whiteColor] setFill];
    [whiteDot fill];
    [path appendPath:whiteDot];
    
}



@end
