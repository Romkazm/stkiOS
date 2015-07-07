// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to STKSticker.m instead.

#import "_STKSticker.h"

const struct STKStickerAttributes STKStickerAttributes = {
	.stickerMessage = @"stickerMessage",
	.stickerName = @"stickerName",
};

const struct STKStickerRelationships STKStickerRelationships = {
	.stickerPack = @"stickerPack",
};

@implementation STKStickerID
@end

@implementation _STKSticker

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"STKSticker" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"STKSticker";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"STKSticker" inManagedObjectContext:moc_];
}

- (STKStickerID*)objectID {
	return (STKStickerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic stickerMessage;

@dynamic stickerName;

@dynamic stickerPack;

@end

