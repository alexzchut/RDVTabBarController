//
//  BKClient+Subscriptions.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 04/06/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (Subscriptions)

- (void)addSubscription:(NSString *)receipt price:(NSString *)price currency:(NSString *)currency locale:(NSString *)locale sandbox:(BOOL)sandbox success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)addSubscription:(NSString *)receipt price:(NSString *)price locale:(NSString *)locale sandbox:(BOOL)sandbox success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)addSubscription:(NSString *)receipt price:(NSString *)price locale:(NSString *)locale success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
