//
//  STKStickersDataModel.h
//  StickerFactory
//
//  Created by Vadim Degterev on 08.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class STKStickerObject;

@interface STKStickersDataModel : NSObject

@property (strong, nonatomic) NSArray *stickerPacks;

- (void) updateStickers;
- (void) updateRecentStickers;
- (void) incrementStickerUsedCount:(STKStickerObject*) sticker;


@end
