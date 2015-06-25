//
//  NSString+Stickers.m
//  StickerFactory
//
//  Created by Vadim Degterev on 24.06.15.
//  Copyright (c) 2015 908. All rights reserved.
//

#import "NSString+Stickers.h"

@implementation NSString (Stickers)

- (BOOL)isSticker {
    
    NSString *regexPattern = @"^\\[\\[[a-zA-Z0-9]+_[a-zA-Z0-9]+\\]\\]$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPattern];
    
    BOOL isStickerName = [predicate evaluateWithObject:self];
    
    return isStickerName;
}

@end
