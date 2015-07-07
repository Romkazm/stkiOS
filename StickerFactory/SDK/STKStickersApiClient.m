//
//  STKStickersApiClient.m
//  StickerFactory
//
//  Created by Vadim Degterev on 07.07.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKStickersApiClient.h"
#import <AFNetworking.h>
#import "STKStickersMapper.h"

@interface STKStickersApiClient()

@property (strong, nonatomic) STKStickersMapper *mapper;
@property (strong, nonatomic) dispatch_queue_t completionQueue;

@end

@implementation STKStickersApiClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mapper = [[STKStickersMapper alloc] init];
        
        self.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        self.sessionManager.completionQueue = self.completionQueue;
    }
    return self;
}

- (void)getStickersPackWithType:(NSString*)type
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure {
    
    
    NSDictionary *parameters = @{@"type" : type};
    
    __weak typeof(self) weakSelf = self;
    
    [self.sessionManager GET:@"client-packs" parameters:parameters
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         
                         [weakSelf.mapper mappingStickerPacks:responseObject[@"data"] async:NO];
                         
                         if (success) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 success(responseObject);
                             });
                         }
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         if (failure) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 failure(error);
                             });
                         }
                     }];
    
}

@end
