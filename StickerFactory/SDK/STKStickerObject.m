//
//  STKStickerObject.m
//  StickerFactory
//
//  Created by Vadim Degterev on 08.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickerObject.h"
#import "STKSticker.h"

@implementation STKStickerObject

- (instancetype) initWithSticker:(STKSticker*) sticker
{
    self = [super init];
    if (self) {
        self.stickerName = sticker.stickerName;
        self.stickerMessage = sticker.stickerMessage;
        self.usedCount = sticker.usedCount.integerValue;
    }
    return self;
}

@end
