//
//  STKApiClient.m
//  StickerFactory
//
//  Created by Vadim Degterev on 30.06.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKApiClient.h"
#import <AFNetworking.h>

NSString *const kBaseApiUrl = @"http://stk.908.vc:80/api/v1";

@implementation STKApiClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseApiUrl]];
    }
    return self;
}

@end
