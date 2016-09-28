//
//  BKClient+BKProfiles.h
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKProfile.h"
#import "BKSubprofile.h"

@interface BKClient (Profiles)

- (void)getProfilesWithSuccess:(void (^)(NSArray *profiles))success failure:(void (^)(NSError *error))failure;
- (void)getProfilesIncludingSubprofilesWithSuccess:(void (^)(NSArray *profiles))success failure:(void (^)(NSError *error))failure;
- (void)getProfilesIncludingLockedProfiles:(BOOL)locked success:(void (^)(NSArray *profiles))success failure:(void (^)(NSError *error))failure;

- (void)getProfileWithID:(NSString *)profileID success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure;

- (void)getFollowerCountForProfile:(NSString *)profileID since:(NSString *)since before:(NSString *)before success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createProfileWithService:(NSString *)service serviceID:(NSString *)serviceID serviceType:(NSString *)serviceType accessToken:(NSString *)serviceAccessToken accessTokenSecret:(NSString *)accessTokenSecret success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure;

- (void)createProfileWithService:(NSString *)service oAuthToken:(NSString *)oAuthToken oAuthVerifier:(NSString *)oAuthVerifier oAuthTokenSecret:(NSString *)oAuthTokenSecret success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure;

- (void)createProfileWithService:(NSString *)service oAuthVerifier:(NSString *)oAuthVerifier success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure;

- (void)reconnectProfile:(NSString *)profileID service:(NSString *)service accessToken:(NSString *)serviceAccessToken accessTokenSecret:(NSString *)accessTokenSecret success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)reconnectProfile:(NSString *)profileID service:(NSString *)service oAuthVerifier:(NSString *)oAuthVerifier success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure;

- (void)reconnectProfile:(NSString *)profileID service:(NSString *)service oAuthToken:(NSString *)oAuthToken oAuthVerifier:(NSString *)oAuthVerifier oAuthTokenSecret:(NSString *)oAuthTokenSecret success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)reconnectProfile:(NSString *)profileID parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
