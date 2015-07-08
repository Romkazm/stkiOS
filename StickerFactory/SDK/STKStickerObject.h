//
//  STKStickerObject.h
//  StickerFactory
//
//  Created by Vadim Degterev on 08.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STKSticker;

@interface STKStickerObject : NSObject

@property (strong, nonatomic) NSString *stickerName;
@property (strong, nonatomic) NSString *stickerMessage;
@property (assign, nonatomic) NSInteger usedCount;

- (instancetype) initWithSticker:(STKSticker*) sticker;

@end
