//
//  BKClient+BKUpdates.m
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+ProfileUpdates.h"

@implementation BKClient (ProfileUpdates)

#pragma mark -
#pragma mark - Pending Updates

- (void)getPendingUpdatesForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self getPendingUpdatesForProfile:profileID page:page count:@"20" success:success failure:failure];
}

- (void)getPendingUpdatesForProfile:(NSString *)profileID page:(NSString *)page count:(NSString *)count success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    
    [self GET:[NSString stringWithFormat:@"profiles/%@/updates/pending.json?access_token=%@&page=%@&count=%@&resolve=true", profileID, self.accessToken, page, count] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKUpdate.class fromJSONArray:[responseObject valueForKey:@"updates"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Draft Updates

- (void)getDraftUpdatesForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self getDraftUpdatesForProfile:profileID page:page count:@"20" success:success failure:failure];
}

- (void)getDraftUpdatesForProfile:(NSString *)profileID page:(NSString *)page count:(NSString *)count success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/updates/drafts.json?access_token=%@&page=%@&count=%@&resolve=true", profileID, self.accessToken, page, count] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKUpdate.class fromJSONArray:[responseObject valueForKey:@"updates"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Sent Updates

- (void)getSentUpdatesForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self getSentUpdatesForProfile:profileID page:page metricFilter:@"" reverse:NO typeFilter:@"" success:success failure:failure];
}

- (void)getSentUpdatesForProfile:(NSString *)profileID page:(NSString *)page metricFilter:(NSString *)metricFilter reverse:(BOOL)reverse typeFilter:(NSString *)typeFilter success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/updates/sent.json?access_token=%@&page=%@&resolve=true&metric=%@&reverse=%@&type_filter=%@", profileID, self.accessToken, page, metricFilter, (reverse ? @"true" : @"false"), typeFilter] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKUpdate.class fromJSONArray:[responseObject valueForKey:@"updates"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getSentUpdatesForProfile:(NSString *)profileID since:(NSString *)since before:(NSString *)before success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/updates/sent.json?advanced=true&since=%@&before=%@&access_token=%@&resolve=true&analysis=true", profileID, since, before, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKUpdate.class fromJSONArray:[responseObject valueForKey:@"updates"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - 
#pragma mark - Service Posts

- (void)getServiceUpdatesForProfile:(NSString *)profileID maxUpdateID:(NSString *)maxUpdateID success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/updates/service_posts.json?access_token=%@&max_update_id=%@", profileID, self.accessToken, maxUpdateID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKUpdate.class fromJSONArray:[responseObject valueForKey:@"updates"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];}

#pragma mark -
#pragma mark - Reorder

- (void)reorderUpdatesForProfile:(NSString *)profileID order:(NSArray *)order success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{ @"order" : order };
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/updates/reorder.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Shuffle

- (void)shuffleUpdatesForProfile:(NSString *)profileID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"profiles/%@/updates/shuffle.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
