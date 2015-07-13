//
//  STKStickerPanel.h
//  StickerFactory
//
//  Created by Vadim Degterev on 06.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STKStickerPanel;

@protocol STKStickerPanelDelegate <NSObject>

- (void) stickerPanel:(STKStickerPanel*)stickerPanel didSelectStickerWithMessage:(NSString*) stickerMessage;

@end

@interface STKStickerPanel : UIView

@property (weak, nonatomic) id<STKStickerPanelDelegate> delegate;


// Colors
@property (strong, nonatomic) UIColor *headerBackgroundColor;

// Placeholders
@property (strong, nonatomic) UIImage *stickerPlaceholder;
@property (strong, nonatomic) UIImage *tabPlaceholder;

// Placeholder colors
@property (strong, nonatomic) UIColor *stickerPlaceholderTintColor;
@property (strong, nonatomic) UIColor *tabPlaceholderTintColor;

@end
