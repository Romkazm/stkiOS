#import "STKStickerPack.h"
#import "NSManagedObjectContext+STKAdditions.h"
#import "NSManagedObject+STKAdditions.h"
#import "STKSticker.h"

@interface STKStickerPack ()

// Private interface goes here.

@end

@implementation STKStickerPack

// Custom logic goes here.

+ (instancetype) getRecentsPack {
    
    NSString *packName = @"Recent";
    STKStickerPack *pack = [STKStickerPack stk_objectWithUniqueAttribute:STKStickerPackAttributes.packName value:packName context:[NSManagedObjectContext stk_defaultContext]];
    pack.packName = packName;
    NSArray *recentStickers = [STKSticker stk_getRecentStickers];
    if (recentStickers) {
        [pack addStickers:[NSOrderedSet orderedSetWithArray:recentStickers]];
        return pack;
    }
    return nil;
}

@end
