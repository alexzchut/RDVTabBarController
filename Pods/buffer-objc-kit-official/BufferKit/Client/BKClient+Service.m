//
//  BKClient+Service.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 08/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+Service.h"

@implementation BKClient (Service)

- (void)getPagesForService:(NSString *)service authCode:(NSString *)authCode accessToken:(NSString *)accessToken authResponse:(NSDictionary *)authResponse success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self getPagesForService:service authCode:authCode accessToken:accessToken authResponse:authResponse success:success failure:failure];
}

- (void)getPagesForService:(NSString *)service authCode:(NSString *)authCode accessToken:(NSString *)accessToken authResponse:(NSDictionary *)authResponse oauthVerifier:(NSString *)oauthVerifier success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    // Add relevant params
    if(authCode){
        [parameters addEntriesFromDictionary:@{ @"service_code" : authCode }];
    } else if(accessToken){
        [parameters addEntriesFromDictionary:@{ @"service_access_token" : accessToken }];
    } else if(authResponse){
        [parameters addEntriesFromDictionary:@{ @"service_access_token" : [self json_encode:authResponse] }];
    } else if(oauthVerifier) {
        [parameters addEntriesFromDictionary:@{ @"service_oauth_verifier" : oauthVerifier }];
    }
    
    [self POST:[NSString stringWithFormat:@"service/pages.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getPageForService:(NSString *)service accessToken:(NSString *)accessToken serviceID:(NSString *)serviceID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    // Add relevant params
    [parameters addEntriesFromDictionary:@{ @"service_access_token" : accessToken }];
    
    [self POST:[NSString stringWithFormat:@"service/page/%@.json?access_token=%@", serviceID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (NSString *)json_encode:(id)obj {
    BOOL is_primative = false;
    if(![obj isKindOfClass:[NSArray class]] && ![obj isKindOfClass:[NSDictionary class]]){
        is_primative = true;
        obj = [NSArray arrayWithObject: obj];
    }
    id data = [NSJSONSerialization dataWithJSONObject:obj options:0 error:nil];
    NSError *err = nil;
    NSString *str = [[NSString alloc] initWithData:data encoding:[NSString defaultCStringEncoding]];
    if(err){
        return nil;
    }
    if(is_primative){
        str = [str substringWithRange:NSMakeRange(1, [str length]-2)];
    }
    return str;
}

@end
