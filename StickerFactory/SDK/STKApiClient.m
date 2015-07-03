//
//  STKApiClient.m
//  StickerFactory
//
//  Created by Vadim Degterev on 30.06.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKApiClient.h"
#import <AFNetworking.h>

NSString *const STKApiVersion = @"v1";
NSString *const STKBaseApiUrl = @"http://work.stk.908.vc/api";

@implementation STKApiClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *baseUrl = [NSString stringWithFormat:@"%@/%@", STKBaseApiUrl, STKApiVersion];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    }
    return self;
}

@end
