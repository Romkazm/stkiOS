//
//  STKStickersMapper.m
//  StickerFactory
//
//  Created by Vadim Degterev on 07.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickersMapper.h"
#import <CoreData/CoreData.h>
#import "NSManagedObjectContext+STKAdditions.h"
#import "NSManagedObject+STKAdditions.h"
#import "STKStickerPack.h"
#import "STKSticker.h"

@interface STKStickersMapper()

@property (strong, nonatomic) NSManagedObjectContext *backgroundContext;

@end

@implementation STKStickersMapper

- (void)mappingStickerPacks:(NSArray *)stickerPacks async:(BOOL)async {
    
    __weak typeof(self) weakSelf = self;
    
    if (async) {
        [self.backgroundContext performBlock:^{
            [weakSelf createModelsAndSaveFromStickerPacks:stickerPacks];
        }];
    } else {
        [self.backgroundContext performBlockAndWait:^{
           [weakSelf createModelsAndSaveFromStickerPacks:stickerPacks];
        }];
    }
}

- (void) createModelsAndSaveFromStickerPacks:(NSArray*) stickerPacks {
    
//    [STKStickerPack stk_deleteAllInContext:self.backgroundContext];
    
    for (NSDictionary *pack in stickerPacks) {
        NSString *packName = pack[@"pack_name"];
        
        STKStickerPack *packModel = [STKStickerPack stk_objectWithUniqueAttribute:STKStickerPackAttributes.packName value:packName context:self.backgroundContext];
        packModel.packName = packName;
        packModel.packTitle = pack[@"title"];
        packModel.artist = pack[@"artist"];
        packModel.price = pack[@"price"];
        
        NSArray *stickersArray = pack[@"stickers"];
        
        if (stickersArray) {
            
            for (NSDictionary *sticker in stickersArray) {
                 NSString *stickerName = sticker[@"name"];
                STKSticker *stickerModel = [STKSticker stk_objectWithUniqueAttribute:STKStickerAttributes.stickerName value:stickerName context:self.backgroundContext];
               
                stickerModel.stickerName = stickerName;
                stickerModel.stickerMessage = [NSString stringWithFormat:@"[[%@_%@]]",packModel.packName, stickerName];
                
                [packModel addStickersObject:stickerModel];
                
            }
        }
    }
    
    [self.backgroundContext save:nil];
}

- (NSManagedObjectContext *)backgroundContext {
    if (!_backgroundContext) {
        _backgroundContext = [NSManagedObjectContext stk_backgroundContext];
    }
    return _backgroundContext;
}



@end
