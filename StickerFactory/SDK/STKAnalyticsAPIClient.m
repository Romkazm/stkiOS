//
//  STKAnalyticsAPIClient.m
//  StickerFactory
//
//  Created by Vadim Degterev on 30.06.15.
//  Copyright (c) 2015 908 Inc. All rights reserved.
//

#import "STKAnalyticsAPIClient.h"
#import <AFNetworking.h>
#import "STKStatistic.h"
#import "STKUtility.h"
#import "STKUUIDManager.h"
#import "STKApiKeyManager.h"

@implementation STKAnalyticsAPIClient

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addHeadersForRequestSerializer];
    }
    return self;
}

- (void) addHeadersForRequestSerializer {
    AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
    
    [serializer setValue:STKApiVersion forHTTPHeaderField:@"ApiVersion"];
    [serializer setValue:@"iOS" forHTTPHeaderField:@"Platform"];
    [serializer setValue:[STKUUIDManager generatedDeviceToken] forHTTPHeaderField:@"DeviceId"];
    NSInteger scale = (NSInteger)[[UIScreen mainScreen] scale];
    [serializer setValue:[NSString stringWithFormat:@"%ld",(long)scale] forHTTPHeaderField:@"Density"];
    [serializer setValue:[STKApiKeyManager apiKey] forHTTPHeaderField:@"ApiKey"];
    [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    self.sessionManager.requestSerializer = serializer;

}


- (void)sendStatistics:(NSArray *)statisticsArray success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (STKStatistic *statistic in statisticsArray) {
        [array addObject:[statistic dictionary]];
    }
    
    [self.sessionManager POST:@"track-statistic" parameters:array success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
//        NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
