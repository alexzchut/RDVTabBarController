//
//  BKClient+Service.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 08/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (Service)

- (void)getPagesForService:(NSString *)service authCode:(NSString *)authCode accessToken:(NSString *)accessToken authResponse:(NSDictionary *)authResponse success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getPagesForService:(NSString *)service authCode:(NSString *)authCode accessToken:(NSString *)accessToken authResponse:(NSDictionary *)authResponse oauthVerifier:(NSString *)oauthVerifier success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getPageForService:(NSString *)service accessToken:(NSString *)accessToken serviceID:(NSString *)serviceID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
