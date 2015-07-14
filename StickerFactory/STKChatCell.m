//
//  STKChatCell.m
//  StickerFactory
//
//  Created by Vadim Degterev on 03.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKChatCell.h"
#import "STKStickerFactory.h"

@implementation STKChatCell

- (void) fillWithStickerMessage:(NSString*) message {
    
    if ([STKStickersManager isStickerMessage:message]) {
        [self.stickerImageView stk_setStickerWithMessage:message completion:nil];
    }
    
}

@end
