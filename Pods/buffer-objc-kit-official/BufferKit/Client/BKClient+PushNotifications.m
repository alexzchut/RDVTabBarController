//
//  BKClient+PushNotifications.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/10/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+PushNotifications.h"

@implementation BKClient (PushNotifications)

- (void)getPushNotificationsWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self getNotificationsWithSuccess:success failure:failure];
}

- (void)getNotificationsWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"push_notifications/channels.json?access_token=%@", self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)subscribeDeviceWithToken:(NSString *)token uuid:(NSString *)uuid notifications:(NSArray *)notifications success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"device_token" : token }];
    
    [parameters addEntriesFromDictionary:@{ @"uuid" : uuid }];
    
    [parameters addEntriesFromDictionary:@{ @"device_type" : @"ios" }];
    
    if([notifications count] != 0){
        [parameters addEntriesFromDictionary:@{ @"channels" : notifications }];
    }
    
    [self POST:[NSString stringWithFormat:@"push_notifications/subscribe.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)unsubscribeDeviceWithToken:(NSString *)token uuid:(NSString *)uuid notifications:(NSArray *)notifications success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"device_token" : token }];
    
    [parameters addEntriesFromDictionary:@{ @"uuid" : uuid }];
    
    [parameters addEntriesFromDictionary:@{ @"device_type" : @"ios" }];
    
    if([notifications count] != 0){
        [parameters addEntriesFromDictionary:@{ @"channels" : notifications }];
    }
    
    [self POST:[NSString stringWithFormat:@"push_notifications/unsubscribe.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getDeviceInfoWithUUID:(NSString *)uuid success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"push_notifications/device_info.json?access_token=%@&uuid=%@", self.accessToken, uuid] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
