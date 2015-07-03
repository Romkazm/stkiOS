//
//  NSManagedObject+STKAdditions.m
//  StickerFactory
//
//  Created by Vadim Degterev on 01.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "NSManagedObject+STKAdditions.h"

@implementation NSManagedObject (STKAdditions)

#pragma mark - Find

+ (NSArray *)stk_findAllInContext:(NSManagedObjectContext*) context {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = [NSEntityDescription entityForName:[self stk_entityName] inManagedObjectContext:context];
    
    __block NSArray *objects = nil;
    
    [context performBlockAndWait:^{
       
        NSError *error = nil;
        
        objects = [context executeFetchRequest:request error:&error];
        
    }];
    
    return objects;
    
}

#pragma mark - Delete

+ (void)stk_deleteAllInContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setReturnsObjectsAsFaults:YES];
    [request setIncludesPropertyValues:NO];
    request.entity = [NSEntityDescription entityForName:[self stk_entityName] inManagedObjectContext:context];
    
    NSArray *objects = [context executeFetchRequest:request error:nil];
    
    for (id object in objects) {
        [context deleteObject:object];
    }
    
}

+ (NSString*) stk_entityName {
    NSString *entityName;
    
    if ([self respondsToSelector:@selector(entityName)])
    {
        entityName = [self performSelector:@selector(entityName)];
    }
    
    if ([entityName length] == 0)
    {
        // Remove module prefix from Swift subclasses
        entityName = [NSStringFromClass(self) componentsSeparatedByString:@"."].lastObject;
    }
    
    return entityName;
}


@end
