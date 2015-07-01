//
//  NSManagedObject+STKAdditions.h
//  StickerFactory
//
//  Created by Vadim Degterev on 01.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (STKAdditions)

+ (NSArray *)stk_findAllInContext:(NSManagedObjectContext*) context;


+ (void) stk_deleteAllInContext:(NSManagedObjectContext*) context;


@end
