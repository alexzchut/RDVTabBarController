//
//  BKClient+BKProfiles.m
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+Profiles.h"

@implementation BKClient (Profiles)

#pragma mark - Profiles

- (void)getProfilesWithSuccess:(void (^)(NSArray *profiles))success failure:(void (^)(NSError *error))failure {
    [self getProfilesIncludingLockedProfiles:NO success:success failure:failure];
}

- (void)getProfilesIncludingSubprofilesWithSuccess:(void (^)(NSArray *profiles))success failure:(void (^)(NSError *error))failure {
    [self getProfilesIncludingLockedProfiles:NO success:success failure:failure];
}

- (void)getProfilesIncludingLockedProfiles:(BOOL)locked success:(void (^)(NSArray *profiles))success failure:(void (^)(NSError *error))failure {
    
    NSString *path = [NSString stringWithFormat:@"profiles.json?subprofiles=1&access_token=%@", self.accessToken];
    
    if(locked){
        path = [NSString stringWithFormat:@"profiles.json?subprofiles=1&locked=1&access_token=%@", self.accessToken];
    }
    
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *profiles = [MTLJSONAdapter modelsOfClass:BKProfile.class fromJSONArray:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(profiles);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


- (void)getProfileWithID:(NSString *)profileID success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        BKProfile *profile = [MTLJSONAdapter modelOfClass:BKProfile.class fromJSONDictionary:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(profile);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Follower Count

- (void)getFollowerCountForProfile:(NSString *)profileID since:(NSString *)since before:(NSString *)before success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/followers/count.json?access_token=%@&resolve=true&since=%@&before=%@", profileID, self.accessToken, since, before] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Create

- (void)createProfileWithService:(NSString *)service serviceID:(NSString *)serviceID serviceType:(NSString *)serviceType accessToken:(NSString *)serviceAccessToken accessTokenSecret:(NSString *)accessTokenSecret success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add service parameter
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    // Add service id parameter
    if(serviceID){
        [parameters addEntriesFromDictionary:@{ @"service_id" : serviceID }];
    }
        
    // Add service type parameter
    if(serviceType){
        [parameters addEntriesFromDictionary:@{ @"service_type" : serviceType }];
    }
    
    // Add service access token parameter
    if(serviceAccessToken){
        [parameters addEntriesFromDictionary:@{ @"service_access_token" : serviceAccessToken }];
    }
        
    // Add service access token secret (if required)
    if(([service isEqualToString:@"twitter"] || [service isEqualToString:@"linkedin"]) && accessTokenSecret){
        [parameters addEntriesFromDictionary:@{ @"service_access_token_secret" : accessTokenSecret }];
    }
    
    [self createProfileWithParameters:parameters success:success failure:failure];
}

- (void)createProfileWithService:(NSString *)service oAuthToken:(NSString *)oAuthToken oAuthVerifier:(NSString *)oAuthVerifier oAuthTokenSecret:(NSString *)oAuthTokenSecret success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add service parameter
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    // Add service id parameter
    if(oAuthToken){
        [parameters addEntriesFromDictionary:@{ @"service_oauth_token" : oAuthToken }];
    }
    
    // Add service access token parameter
    if(oAuthVerifier){
        [parameters addEntriesFromDictionary:@{ @"service_oauth_verifier" : oAuthVerifier }];
    }
    
    // Add service access token secret (if required)
    if(oAuthTokenSecret){
        [parameters addEntriesFromDictionary:@{ @"service_oauth_token_secret" : oAuthTokenSecret }];
    }
    
    [self createProfileWithParameters:parameters success:success failure:failure];
}

- (void)createProfileWithService:(NSString *)service oAuthVerifier:(NSString *)oAuthVerifier success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add service parameter
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    
    [parameters addEntriesFromDictionary:@{ @"service_oauth_token" : @"1" }];
    [parameters addEntriesFromDictionary:@{ @"service_oauth_token_secret" : @"1" }];
    
    [parameters addEntriesFromDictionary:@{ @"service_oauth_verifier" : oAuthVerifier }];
    
    [self createProfileWithParameters:parameters success:success failure:failure];
}

- (void)createProfileWithParameters:(NSDictionary *)parameters success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure {
    
    //Add a default time zone to the profile for ease of use
    NSString *tzName = [NSTimeZone localTimeZone].name;
    if (tzName && tzName.length > 0) {
        NSDictionary *timezone = @{@"timezone": tzName};
        
        NSMutableDictionary *updatedParams = [NSMutableDictionary dictionaryWithDictionary:parameters];
        [updatedParams addEntriesFromDictionary:timezone];
        parameters = updatedParams;
    }
    
    [self POST:[NSString stringWithFormat:@"profiles/create.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        BKProfile *profile = [MTLJSONAdapter modelOfClass:BKProfile.class fromJSONDictionary:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(profile);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


- (void)reconnectProfile:(NSString *)profileID service:(NSString *)service accessToken:(NSString *)serviceAccessToken accessTokenSecret:(NSString *)accessTokenSecret success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add service parameter
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    // Add service access token parameter
    [parameters addEntriesFromDictionary:@{ @"service_access_token" : serviceAccessToken }];
    
    // Add service access token secret (if required)
    if([service isEqualToString:@"twitter"] || [service isEqualToString:@"linkedin"]){
        [parameters addEntriesFromDictionary:@{ @"service_access_token_secret" : accessTokenSecret }];
    }
    
    [self reconnectProfile:profileID parameters:parameters success:success failure:failure];
}

- (void)reconnectProfile:(NSString *)profileID service:(NSString *)service oAuthVerifier:(NSString *)oAuthVerifier success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add service parameter
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    [parameters addEntriesFromDictionary:@{ @"service_oauth_verifier" : oAuthVerifier }];
    
    [self reconnectProfile:profileID parameters:parameters success:success failure:failure];
}


- (void)reconnectProfile:(NSString *)profileID service:(NSString *)service oAuthToken:(NSString *)oAuthToken oAuthVerifier:(NSString *)oAuthVerifier oAuthTokenSecret:(NSString *)oAuthTokenSecret success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add service parameter
    [parameters addEntriesFromDictionary:@{ @"service" : service }];
    
    // Add service id parameter
    [parameters addEntriesFromDictionary:@{ @"service_oauth_token" : oAuthToken }];
    
    // Add service access token parameter
    [parameters addEntriesFromDictionary:@{ @"service_oauth_verifier" : oAuthVerifier }];
    
    // Add service access token secret (if required)
    [parameters addEntriesFromDictionary:@{ @"service_oauth_token_secret" : oAuthTokenSecret }];
    
    [self reconnectProfile:profileID parameters:parameters success:success failure:failure];
}

- (void)reconnectProfile:(NSString *)profileID parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [self POST:[NSString stringWithFormat:@"profiles/%@/reconnect.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
