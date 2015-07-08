// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to STKSticker.m instead.

#import "_STKSticker.h"

const struct STKStickerAttributes STKStickerAttributes = {
	.stickerMessage = @"stickerMessage",
	.stickerName = @"stickerName",
	.usedCount = @"usedCount",
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

	if ([key isEqualToString:@"usedCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"usedCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic stickerMessage;

@dynamic stickerName;

@dynamic usedCount;

- (int64_t)usedCountValue {
	NSNumber *result = [self usedCount];
	return [result longLongValue];
}

- (void)setUsedCountValue:(int64_t)value_ {
	[self setUsedCount:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveUsedCountValue {
	NSNumber *result = [self primitiveUsedCount];
	return [result longLongValue];
}

- (void)setPrimitiveUsedCountValue:(int64_t)value_ {
	[self setPrimitiveUsedCount:[NSNumber numberWithLongLong:value_]];
}

@dynamic stickerPack;

@end

