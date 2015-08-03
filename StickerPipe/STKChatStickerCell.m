//
//  STKChatCell.m
//  StickerFactory
//
//  Created by Vadim Degterev on 03.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKChatStickerCell.h"
#import "STKStickerPipe.h"

@implementation STKChatStickerCell

- (void) fillWithStickerMessage:(NSString*) message {
    self.stickerMessage = message;
    if ([STKStickersManager isStickerMessage:message]) {
        [self.stickerImageView stk_setStickerWithMessage:message placeholder:nil placeholderColor:nil progress:nil completion:nil];
        
    }
    
}

@end
