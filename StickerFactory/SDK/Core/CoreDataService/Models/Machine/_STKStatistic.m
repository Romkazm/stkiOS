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

	if ([key isEqualToString:@"timeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"time"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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

- (double)timeValue {
	NSNumber *result = [self time];
	return [result doubleValue];
}

- (void)setTimeValue:(double)value_ {
	[self setTime:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveTimeValue {
	NSNumber *result = [self primitiveTime];
	return [result doubleValue];
}

- (void)setPrimitiveTimeValue:(double)value_ {
	[self setPrimitiveTime:[NSNumber numberWithDouble:value_]];
}

@dynamic value;

- (int64_t)valueValue {
	NSNumber *result = [self value];
	return [result longLongValue];
}

- (void)setValueValue:(int64_t)value_ {
	[self setValue:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveValueValue {
	NSNumber *result = [self primitiveValue];
	return [result longLongValue];
}

- (void)setPrimitiveValueValue:(int64_t)value_ {
	[self setPrimitiveValue:[NSNumber numberWithLongLong:value_]];
}

@end

