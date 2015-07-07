// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to STKStickerPack.m instead.

#import "_STKStickerPack.h"

const struct STKStickerPackAttributes STKStickerPackAttributes = {
	.artist = @"artist",
	.packName = @"packName",
	.packTitle = @"packTitle",
	.price = @"price",
};

const struct STKStickerPackRelationships STKStickerPackRelationships = {
	.stickers = @"stickers",
};

@implementation STKStickerPackID
@end

@implementation _STKStickerPack

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"STKStickerPack" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"STKStickerPack";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"STKStickerPack" inManagedObjectContext:moc_];
}

- (STKStickerPackID*)objectID {
	return (STKStickerPackID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic artist;

@dynamic packName;

@dynamic packTitle;

@dynamic price;

- (float)priceValue {
	NSNumber *result = [self price];
	return [result floatValue];
}

- (void)setPriceValue:(float)value_ {
	[self setPrice:[NSNumber numberWithFloat:value_]];
}

- (float)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result floatValue];
}

- (void)setPrimitivePriceValue:(float)value_ {
	[self setPrimitivePrice:[NSNumber numberWithFloat:value_]];
}

@dynamic stickers;

- (NSMutableSet*)stickersSet {
	[self willAccessValueForKey:@"stickers"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"stickers"];

	[self didAccessValueForKey:@"stickers"];
	return result;
}

@end

