//
//  STKLinksHelper.m
//  StickerFactory
//
//  Created by Vadim Degterev on 24.06.15.
//  Copyright (c) 2015 908. All rights reserved.
//

#import "STKLinksHelper.h"
#import <UIKit/UIKit.h>


static NSString* const  kAPIUrl = @"http://work.stk.908.vc/stk/";
//static NSString* const  kAPIVersion = @"v1";

@implementation STKLinksHelper

+ (NSURL *)urlForStikerMessage:(NSString *)stickerMessage {
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"[]"];
    NSString *packNameAndStickerName = [stickerMessage stringByTrimmingCharactersInSet:characterSet];
    
    NSArray *separaredStickerNames = [packNameAndStickerName componentsSeparatedByString:@"_"];
    NSString *packName = [separaredStickerNames firstObject];
    NSString *stickerName = [separaredStickerNames lastObject];
    
    NSString *dimension = [self scaleString];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@_%@.png", packName, stickerName, dimension];
    
    NSURL *url = [NSURL URLWithString:urlString relativeToURL:[NSURL URLWithString:kAPIUrl]];
    
    return url;
    
}

+ (NSString*) scaleString {
    
    NSInteger sclaFactor =  (NSInteger)[[UIScreen mainScreen]scale];
    
    NSString *dimension = nil;
    
    //Android style scale factor
    switch (sclaFactor) {
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
