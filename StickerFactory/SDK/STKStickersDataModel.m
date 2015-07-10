//
//  STKStickersDataModel.m
//  StickerFactory
//
//  Created by Vadim Degterev on 08.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickersDataModel.h"
#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+STKAdditions.h"
#import "NSManagedObject+STKAdditions.h"
#import "STKStickerPack.h"
#import "STKStickerObject.h"
#import "STKStickerPackObject.h"
#import "STKSticker.h"

@interface STKStickersDataModel()

@property (strong, nonatomic) NSManagedObjectContext *defaultContext;

@end

@implementation STKStickersDataModel

- (NSArray*) getStickerPacks {
    
    NSArray *stickerPacks = [STKStickerPack stk_findAllInContext:self.defaultContext];
    
    NSMutableArray *result = [NSMutableArray array];
    
    for (STKStickerPack *pack in stickerPacks) {
        STKStickerPackObject *stickerPackObject = [[STKStickerPackObject alloc] initWithStickerPack:pack];
        [result addObject:stickerPackObject];
    }
    [result sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:STKStickerPackAttributes.packName ascending:YES]]];
    
    STKStickerPackObject *recentPack = [self recentStickerPack];
    if (recentPack) {
        [result insertObject:recentPack atIndex:0];
    }
    
    return [NSArray arrayWithArray:result];
    
}

- (STKStickerPackObject*) recentStickerPack {
    
    NSArray *recentSticker = [STKSticker stk_getRecentStickers];
    if (recentSticker.count > 0) {
        NSArray *sortedRecentStickers = [recentSticker sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:STKStickerAttributes.usedCount ascending:NO]]];
        STKStickerPackObject *recentPack = [STKStickerPackObject new];
        recentPack.packName = @"Recent";
        recentPack.packTitle = @"Recent";
        recentPack.stickers = sortedRecentStickers;
        return recentPack;
    }
    
    return nil;
}

- (void)updateRecentStickers {
    
    STKStickerPackObject *stickerPack = self.stickerPacks.firstObject;
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.stickerPacks];
    if ([stickerPack.packName isEqualToString:@"Recent"]) {
        [tempArray removeObjectAtIndex:0];
    }
    STKStickerPackObject *recentPack = [self recentStickerPack];
    if (recentPack) {
        [tempArray insertObject:recentPack atIndex:0];
    }
    
    self.stickerPacks = [NSArray arrayWithArray:tempArray];
    
}

- (void)updateStickers {
    self.stickerPacks = [self getStickerPacks];
    
}

- (void)incrementStickerUsedCount:(STKStickerObject *)sticker {
    
    __weak typeof(self) weakSelf = self;
    
    [self.defaultContext performBlock:^{
        STKSticker *stickerModel = [STKSticker modelForObject:sticker];
        NSInteger usedCount = [stickerModel.usedCount integerValue];
        usedCount++;
        stickerModel.usedCount = @(usedCount);
        
        [weakSelf.defaultContext save:nil];
    }];
    
}

#pragma mark - Properties

- (NSManagedObjectContext *)defaultContext {
    if (!_defaultContext) {
        _defaultContext = [NSManagedObjectContext stk_defaultContext];
    }
    return _defaultContext;
}

@end
