// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to STKStickerPack.h instead.

#import <CoreData/CoreData.h>

extern const struct STKStickerPackAttributes {
	__unsafe_unretained NSString *artist;
	__unsafe_unretained NSString *packName;
	__unsafe_unretained NSString *packTitle;
	__unsafe_unretained NSString *price;
} STKStickerPackAttributes;

extern const struct STKStickerPackRelationships {
	__unsafe_unretained NSString *stickers;
} STKStickerPackRelationships;

@class STKSticker;

@interface STKStickerPackID : NSManagedObjectID {}
@end

@interface _STKStickerPack : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) STKStickerPackID* objectID;

@property (nonatomic, strong) NSString* artist;

//- (BOOL)validateArtist:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* packName;

//- (BOOL)validatePackName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* packTitle;

//- (BOOL)validatePackTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* price;

@property (atomic) float priceValue;
- (float)priceValue;
- (void)setPriceValue:(float)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *stickers;

- (NSMutableSet*)stickersSet;

@end

@interface _STKStickerPack (StickersCoreDataGeneratedAccessors)
- (void)addStickers:(NSSet*)value_;
- (void)removeStickers:(NSSet*)value_;
- (void)addStickersObject:(STKSticker*)value_;
- (void)removeStickersObject:(STKSticker*)value_;

@end

@interface _STKStickerPack (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveArtist;
- (void)setPrimitiveArtist:(NSString*)value;

- (NSString*)primitivePackName;
- (void)setPrimitivePackName:(NSString*)value;

- (NSString*)primitivePackTitle;
- (void)setPrimitivePackTitle:(NSString*)value;

- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (float)primitivePriceValue;
- (void)setPrimitivePriceValue:(float)value_;

- (NSMutableSet*)primitiveStickers;
- (void)setPrimitiveStickers:(NSMutableSet*)value;

@end
