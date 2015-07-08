//
//  STKStickerPackObject.h
//  StickerFactory
//
//  Created by Vadim Degterev on 08.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>'

@class STKStickerPack;

@interface STKStickerPackObject : NSObject

@property (nonatomic, strong) NSString *artist;

@property (nonatomic, strong) NSString *packName;

@property (nonatomic, strong) NSString *packTitle;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, strong) NSArray *stickers;

- (instancetype)initWithStickerPack:(STKStickerPack*) stickerPack;

@end
