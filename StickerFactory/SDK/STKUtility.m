//
//  STKUtility.m
//  StickerFactory
//
//  Created by Vadim Degterev on 26.06.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKUtility.h"
#import <UIKit/UIKit.h>


NSString *const STKUtilityAPIUrl = @"http://stk.908.vc/stk/";


@implementation STKUtility


#pragma mark -

+ (NSURL*) imageUrlForStikerMessage:(NSString *)stickerMessage {
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"[]"];
    NSString *packNameAndStickerName = [stickerMessage stringByTrimmingCharactersInSet:characterSet];
    
    NSArray *separaredStickerNames = [packNameAndStickerName componentsSeparatedByString:@"_"];
    NSString *packName = [separaredStickerNames firstObject];
    NSString *stickerName = [separaredStickerNames lastObject];
    
    NSString *dimension = [self scaleString];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@_%@.png", packName, stickerName, dimension];
    
    NSURL *url = [NSURL URLWithString:urlString relativeToURL:[NSURL URLWithString:STKUtilityAPIUrl]];
    
    return url;
    
}

+ (NSString*) scaleString {
    
    NSInteger scale =  (NSInteger)[[UIScreen mainScreen]scale];
    
    NSString *dimension = nil;
    
    //Android style scale
    switch (scale) {
            case 1:
            dimension = @"mdpi";
            break;
            case 2:
            dimension = @"xhdpi";
            break;
            case 3:
            dimension = @"xxhdpi";
            break;
            
        default:
            break;
    }
    return dimension;
}

@end
