//
//  STKStickersApiClient.m
//  StickerFactory
//
//  Created by Vadim Degterev on 07.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickersApiClient.h"
#import <AFNetworking.h>

@implementation STKStickersApiClient

- (void)getStickersPackWithType:(NSString*)type
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure {
    
    
    NSDictionary *parameters = @{@"type" : type};
    
    [self.sessionManager GET:@"client-packs" parameters:parameters
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         if (success) {
                             success(responseObject);
                         }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
