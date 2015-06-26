//
//  UIImageView+Stickers.m
//  StickerFactory
//
//  Created by Vadim Degterev on 24.06.15.
//  Copyright (c) 2015 908. All rights reserved.
//

#import "UIImageView+Stickers.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation UIImageView (Stickers)




#pragma mark - Builder

- (void) stk_setStickerWithMessage:(NSString *)stickerMessage completion:(STKCompletionBlock)completion {
    
    [self stk_setStickerWithMessage:stickerMessage placeholder:nil progress:nil completion:completion];
    
}


- (void) stk_setStickerWithMessage:(NSString *)stickerMessage placeholder:(UIImage *)placeholder {
    
    [self stk_setStickerWithMessage:stickerMessage placeholder:placeholder progress:nil completion:nil];
}

- (void) stk_setStickerWithMessage:(NSString *)stickerMessage
                   placeholder:(UIImage *)placeholder
                    completion:(STKCompletionBlock)completion
{
    
    [self stk_setStickerWithMessage:stickerMessage placeholder:placeholder progress:nil completion:completion];
}

#pragma mark - Sticker Download

- (void) stk_setStickerWithMessage:(NSString *)stickerMessage placeholder:(UIImage *)placeholder progress:(STKDownloadingProgressBlock)progressBlock completion:(STKCompletionBlock)completion {
    
    
    NSURL *stickerUrl = [STKLinksHelper urlForStikerMessage:stickerMessage];
    
    [self sd_setImageWithURL:stickerUrl placeholderImage:placeholder options:SDWebImageHighPriority progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        if (completion) {
            completion(error, image);
        }
        
    }];
    
}

#pragma mark - Stop loading

- (void)stk_cancelStickerLoading {
    
    [self sd_cancelCurrentImageLoad];
}

@end
