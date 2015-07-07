//
//  STKStickerPanelCell.m
//  StickerFactory
//
//  Created by Vadim Degterev on 07.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickerPanelCell.h"
#import "UIImageView+Stickers.h"
#import "UIImage+Tint.h"

@interface STKStickerPanelCell()

@property (strong, nonatomic) UIImageView *stickerImageView;

@end

@implementation STKStickerPanelCell

- (void)awakeFromNib {
    self.stickerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.0, 5.0, 40.0, 40.0)];
    self.stickerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.stickerImageView];
}

- (void)prepareForReuse {
    [self.stickerImageView stk_cancelStickerLoading];
}

- (void) configureWithStickerMessage:(NSString*)stickerMessage
                         placeholder:(UIImage*)placeholder
                    placeholderColor:(UIColor*)placeholderColor {
    
    UIImage *coloredPlaceholder = [placeholder imageWithImageTintColor:placeholderColor];
    
    [self.stickerImageView stk_setStickerWithMessage:stickerMessage placeholder:coloredPlaceholder];
    
}

@end
