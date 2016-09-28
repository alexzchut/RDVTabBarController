//
//  BKClient+BKUser.m
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+User.h"

@implementation BKClient (User)

#pragma mark - User

- (void)getUserWithSuccess:(void (^)(BKUser *user))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"user.json?access_token=%@", self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        BKUser *user = [MTLJSONAdapter modelOfClass:BKUser.class fromJSONDictionary:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(user);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Friends

- (void)getUsersFriendsWithOffset:(NSString *)offset success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add name to parameters
    [parameters addEntriesFromDictionary:@{ @"offset" : offset }];
    
    [parameters addEntriesFromDictionary:@{ @"count" : @"3000" }];
    
    [self GET:[NSString stringWithFormat:@"user/friends.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getFriendsWithQuery:(NSString *)query success:(void (^)(id responseObject, NSString *query))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters addEntriesFromDictionary:@{ @"q" : query }];
    
    [self GET:[NSString stringWithFormat:@"friends.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject, query);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - S3 Signature

- (void)getUsersS3SignatureWithType:(NSString *)type success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"user/s3_signature.json?access_token=%@&type=%@", self.accessToken, type] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Email

- (void)setEmailForUserWithEmail:(NSString *)email success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"email":email};
    
    [self POST:[NSString stringWithFormat:@"user/update.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        BKUser *user = [MTLJSONAdapter modelOfClass:BKUser.class fromJSONDictionary:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(user);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Contact

- (void)sendSupportMessageWithEmail:(NSString *)email name:(NSString *)name subject:(NSString *)subject message:(NSString *)message success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add name to parameters
    [parameters addEntriesFromDictionary:@{ @"name" : name }];
    
    // Add email to parameters
    [parameters addEntriesFromDictionary:@{ @"email" : email }];
    
    // Add subject to parameters
    [parameters addEntriesFromDictionary:@{ @"subject" : subject }];
    
    // Add message to parameters
    [parameters addEntriesFromDictionary:@{ @"message" : message }];
    
    [self POST:[NSString stringWithFormat:@"user/contact.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Tags

- (void)addUserTag:(NSString *)tag success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"tag":tag};
    
    [self POST:[NSString stringWithFormat:@"user/add_tag.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)userHasTag:(NSString *)tag success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"tag":tag};
    
    [self GET:[NSString stringWithFormat:@"user/has_tag.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Deauthorize

- (void)deauthorizeWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"user/deauthorize.json?access_token=%@", self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
