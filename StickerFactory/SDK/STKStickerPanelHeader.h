//
//  STKStickerPanelHeader.h
//  StickerFactory
//
//  Created by Vadim Degterev on 07.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STKStickerPackObject;

@interface STKStickerPanelHeader : UIView

- (void) setStickerPacks:(NSArray*)stickerPacks;

- (void) setPackSelected:(STKStickerPackObject*)object;
- (void) setPackSelectedAtIndex:(NSInteger)index;

@end
