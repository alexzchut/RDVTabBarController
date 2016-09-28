//
//  BKClient+ProfileGroups.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+ProfileGroups.h"

@implementation BKClient (ProfileGroups)

- (void)getProfileGroupsWithSuccess:(void (^)(NSArray *profileGroups))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profile_groups.json?access_token=%@", self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *profileGroups = [MTLJSONAdapter modelsOfClass:BKProfileGroup.class fromJSONArray:[responseObject valueForKey:@"profile_groups"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(profileGroups);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)addProfileGroupWithName:(NSString *)name profiles:(NSArray *)profileIDs success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add name to parameters
    [parameters addEntriesFromDictionary:@{ @"name" : name }];
    
    // Add profile_ids to parameters
    [parameters addEntriesFromDictionary:@{ @"profile_ids" : profileIDs }];
    
    [self POST:[NSString stringWithFormat:@"profile_groups/create.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)editProfileGroupWithID:(NSString *)groupID name:(NSString *)name profiles:(NSArray *)profileIDs success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add name to parameters
    [parameters addEntriesFromDictionary:@{ @"name" : name }];
    
    // Add profile_ids to parameters
    [parameters addEntriesFromDictionary:@{ @"profile_ids" : profileIDs }];
    
    [self POST:[NSString stringWithFormat:@"profile_groups/%@/update.json?access_token=%@", groupID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)deleteProfileGroupWithID:(NSString *)groupID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"profile_groups/%@/destroy.json?access_token=%@", groupID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
