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
    CGFloat lineWidth = 1.0;
    CGRect rectInsets = CGRectInset(self.bounds,lineWidth,lineWidth);
    UIBezierPath *path =  [UIBezierPath bezierPathWithRoundedRect:rectInsets cornerRadius:CGRectGetHeight(rect) / 2.0];
    [[UIColor redColor] setFill];
    [path fill];
    path.lineWidth = lineWidth;
    [[UIColor whiteColor] setStroke];
    [path stroke];
    
    CGFloat whiteDotWight = rect.size.width / 3.0;
    CGFloat whiteDotHeight = rect.size.height / 3.0;
    CGFloat whiteDotY = CGRectGetMidY(rect) - (whiteDotHeight / 2.0);
    CGFloat whiteDotX = CGRectGetMidX(rect) - (whiteDotWight / 2.0);
    
    UIBezierPath *whiteDot = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(whiteDotX, whiteDotY, whiteDotWight, whiteDotHeight) cornerRadius:whiteDotHeight / 2.0];
    [[UIColor whiteColor] setFill];
    [whiteDot fill];
    [path appendPath:whiteDot];
    
}


@end
