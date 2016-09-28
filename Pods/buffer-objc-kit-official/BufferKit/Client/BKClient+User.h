//
//  BKClient+BKUser.h
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKUser.h"
#import "BKFriend.h"

@interface BKClient (User)

- (void)getUserWithSuccess:(void (^)(BKUser *user))success failure:(void (^)(NSError *error))failure;

- (void)getUsersFriendsWithOffset:(NSString *)offset success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getFriendsWithQuery:(NSString *)query success:(void (^)(id responseObject, NSString *query))success failure:(void (^)(NSError *error))failure;

- (void)getUsersS3SignatureWithType:(NSString *)type success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)setEmailForUserWithEmail:(NSString *)email success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)sendSupportMessageWithEmail:(NSString *)email name:(NSString *)name subject:(NSString *)subject message:(NSString *)message success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)addUserTag:(NSString *)tag success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)userHasTag:(NSString *)tag success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)deauthorizeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
