//
//  STKApiClient.h
//  StickerFactory
//
//  Created by Vadim Degterev on 30.06.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

@interface STKApiClient : NSObject

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;


@end
