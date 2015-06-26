//
//  STKStickersClient.m
//  StickerFactory
//
//  Created by Vadim Degterev on 25.06.15.
//  Copyright (c) 2015 908. All rights reserved.
//

#import "STKStickersManager.h"
#import <SDWebImageManager.h>

static NSString* const  kAPIUrl = @"http://work.stk.908.vc/stk/";


@interface STKStickersManager()

@property (strong, nonatomic) SDWebImageManager *imageManager;

@end

@implementation STKStickersManager

- (void)getStickerForMessage:(NSString *)message progress:(void (^)(NSInteger, NSInteger))progress success:(void (^)(UIImage *))success failure:(void (^)(NSError *, NSString *))failure {
    
    if ([self.class isStickerMessage:message]) {
        NSURL *stickerUrl = [self urlForStikerMessage:message];
        
        [self.imageManager downloadImageWithURL:stickerUrl
                                        options:0
                                       progress:progress
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                          if (error) {
                                              if (failure) {
                                                  failure(error, nil);
                                              }
                                          } else {
                                              if (success) {
                                                  success(image);
                                              }
                                          }
                                      }];
    } else {
        if (failure) {
            failure(nil, @"It's not a sticker");
        }
        NSLog(@"It's not a sticker");
    }

}

#pragma mark - Validation

+ (BOOL)isStickerMessage:(NSString *)message {
    NSString *regexPattern = @"^\\[\\[[a-zA-Z0-9]+_[a-zA-Z0-9]+\\]\\]$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexPattern];
    
    BOOL isStickerMessage = [predicate evaluateWithObject:message];
    
    return isStickerMessage;
}


#pragma mark - Properties

- (SDWebImageManager *)imageManager {
    
    return [SDWebImageManager sharedManager];
}

#pragma mark - Names

- (NSURL*) urlForStikerMessage:(NSString *)stickerMessage {
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"[]"];
    NSString *packNameAndStickerName = [stickerMessage stringByTrimmingCharactersInSet:characterSet];
    
    NSArray *separaredStickerNames = [packNameAndStickerName componentsSeparatedByString:@"_"];
    NSString *packName = [separaredStickerNames firstObject];
    NSString *stickerName = [separaredStickerNames lastObject];
    
    NSString *dimension = [self scaleString];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@_%@.png", packName, stickerName, dimension];
    
    NSURL *url = [NSURL URLWithString:urlString relativeToURL:[NSURL URLWithString:kAPIUrl]];
    
    return url;
    
}

- (NSString*) scaleString {
    
    NSInteger sclaFactor =  (NSInteger)[[UIScreen mainScreen]scale];
    
    NSString *dimension = nil;
    
    //Android style scale factor
    switch (sclaFactor) {
            case 1:
            dimension = @"mdpi";
            break;
            case 2:
            dimension = @"xhdpi";
            break;
            case 3:
            dimension = @"xxhdpi";
            break;
            
        default:
            break;
    }
    return dimension;
}


@end
