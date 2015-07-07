// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to STKSticker.h instead.

#import <CoreData/CoreData.h>

extern const struct STKStickerAttributes {
	__unsafe_unretained NSString *stickerMessage;
	__unsafe_unretained NSString *stickerName;
} STKStickerAttributes;

extern const struct STKStickerRelationships {
	__unsafe_unretained NSString *stickerPack;
} STKStickerRelationships;

@class STKStickerPack;

@interface STKStickerID : NSManagedObjectID {}
@end

@interface _STKSticker : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) STKStickerID* objectID;

@property (nonatomic, strong) NSString* stickerMessage;

//- (BOOL)validateStickerMessage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* stickerName;

//- (BOOL)validateStickerName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) STKStickerPack *stickerPack;

//- (BOOL)validateStickerPack:(id*)value_ error:(NSError**)error_;

@end

@interface _STKSticker (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveStickerMessage;
- (void)setPrimitiveStickerMessage:(NSString*)value;

- (NSString*)primitiveStickerName;
- (void)setPrimitiveStickerName:(NSString*)value;

- (STKStickerPack*)primitiveStickerPack;
- (void)setPrimitiveStickerPack:(STKStickerPack*)value;

@end
