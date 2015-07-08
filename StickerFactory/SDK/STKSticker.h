#import "_STKSticker.h"

@class STKStickerObject;

@interface STKSticker : _STKSticker {}
// Custom logic goes here.

+ (NSArray *)stk_getRecentStickers;

+ (STKSticker*) modelForObject:(STKStickerObject*) object;

@end
