//
//  UIImage+Tint.m
//  StickerFactory
//
//  Created by Vadim Degterev on 29.06.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "UIImage+Tint.h"

@implementation UIImage (Tint)

- (UIImage*)imageWithImageTintColor:(UIColor *)color {
    // Construct new image the same size as this one.
    if (color) {
//        UIImage *image;
//        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
//        CGRect rect = CGRectZero;
//        rect.size = [self size];
//        
//        // tint the image
//        [self drawInRect:rect];
//        [color set];
//        UIRectFillUsingBlendMode(rect, kCGBlendModeMultiply);
//        
//        // restore alpha channel
//        [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
//        
//        image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, self.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
        CGContextClipToMask(context, rect, self.CGImage);
        [color setFill];
        CGContextFillRect(context, rect);
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
    }
    return self;
    
}

@end
