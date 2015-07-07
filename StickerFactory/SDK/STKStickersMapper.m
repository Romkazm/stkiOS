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
    for (NSDictionary *pack in stickerPacks) {
        STKStickerPack *packModel = [NSEntityDescription insertNewObjectForEntityForName:[STKStickerPack entityName] inManagedObjectContext:self.backgroundContext];
        packModel.packName = pack[@"pack_name"];
        packModel.packTitle = pack[@"title"];
        packModel.artist = pack[@"artist"];
        packModel.price = pack[@"price"];
        
        NSArray *stickersArray = pack[@"stickers"];
        
        if (stickersArray) {
            
            for (NSDictionary *sticker in stickersArray) {
                
                STKSticker *stickerModel = [NSEntityDescription insertNewObjectForEntityForName:[STKSticker entityName] inManagedObjectContext:self.backgroundContext];
                NSString *stickerName = sticker[@"name"];
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
