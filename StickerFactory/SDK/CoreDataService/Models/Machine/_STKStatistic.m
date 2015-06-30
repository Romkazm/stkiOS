// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to STKStatistic.m instead.

#import "_STKStatistic.h"

const struct STKStatisticAttributes STKStatisticAttributes = {
	.action = @"action",
	.category = @"category",
	.label = @"label",
	.time = @"time",
	.value = @"value",
};

@implementation STKStatisticID
@end

@implementation _STKStatistic

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"STKStatistic" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"STKStatistic";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"STKStatistic" inManagedObjectContext:moc_];
}

- (STKStatisticID*)objectID {
	return (STKStatisticID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"valueValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"value"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic action;

@dynamic category;

@dynamic label;

@dynamic time;

@dynamic value;

- (int16_t)valueValue {
	NSNumber *result = [self value];
	return [result shortValue];
}

- (void)setValueValue:(int16_t)value_ {
	[self setValue:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveValueValue {
	NSNumber *result = [self primitiveValue];
	return [result shortValue];
}

- (void)setPrimitiveValueValue:(int16_t)value_ {
	[self setPrimitiveValue:[NSNumber numberWithShort:value_]];
}

@end

