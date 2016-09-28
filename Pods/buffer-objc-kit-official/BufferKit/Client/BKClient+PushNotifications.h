//
//  BKClient+PushNotifications.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/10/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (PushNotifications)


- (void)getPushNotificationsWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)getNotificationsWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure __deprecated;

- (void)subscribeDeviceWithToken:(NSString *)token uuid:(NSString *)uuid notifications:(NSArray *)notifications success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)unsubscribeDeviceWithToken:(NSString *)token uuid:(NSString *)uuid notifications:(NSArray *)notifications success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getDeviceInfoWithUUID:(NSString *)uuid success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
