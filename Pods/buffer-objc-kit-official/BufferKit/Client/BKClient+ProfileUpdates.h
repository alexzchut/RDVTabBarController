//
//  BKClient+BKUpdates.h
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKUpdate.h"

@interface BKClient (ProfileUpdates)

- (void)getPendingUpdatesForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)getPendingUpdatesForProfile:(NSString *)profileID page:(NSString *)page count:(NSString *)count success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;


- (void)getDraftUpdatesForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)getDraftUpdatesForProfile:(NSString *)profileID page:(NSString *)page count:(NSString *)count success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)getSentUpdatesForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)getSentUpdatesForProfile:(NSString *)profileID page:(NSString *)page metricFilter:(NSString *)metricFilter reverse:(BOOL)reverse typeFilter:(NSString *)typeFilter success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)getSentUpdatesForProfile:(NSString *)profileID since:(NSString *)since before:(NSString *)before success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)getServiceUpdatesForProfile:(NSString *)profileID maxUpdateID:(NSString *)maxUpdateID success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;


- (void)reorderUpdatesForProfile:(NSString *)profileID order:(NSArray *)order success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)shuffleUpdatesForProfile:(NSString *)profileID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
