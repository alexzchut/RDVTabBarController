//
//  BKClient+ProfileImports.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+ProfileImports.h"
#import "BKClient+Updates.h"

@implementation BKClient (ProfileImports)

#pragma mark - Imports

- (void)getImportsForProfile:(NSString *)profileID success:(void (^)(NSArray *imports))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/imports.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *imports = [MTLJSONAdapter modelsOfClass:BKImport.class fromJSONArray:[responseObject valueForKey:@"imports"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(imports);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Import Posts

- (void)getImportPostsForProfile:(NSString *)profileID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/imports/list.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKImportPost.class fromJSONArray:[responseObject valueForKey:@"updates"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getImportPostsForProfile:(NSString *)profileID import:(NSString *)importID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    
    NSString *path = [NSString stringWithFormat:@"profiles/%@/imports/list.json?access_token=%@&page=%@", profileID, self.accessToken, page];
    
    if(![importID isEqualToString:@""]){
        path = [NSString stringWithFormat:@"%@&ids[]=%@", path, importID];
    }
    
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *updates = [MTLJSONAdapter modelsOfClass:BKImportPost.class fromJSONArray:[responseObject valueForKey:@"updates"] error:&error];
        if(error){
            failure(error);
            return;
        }
        success(updates);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Add Import

- (void)addImportForProfile:(NSString *)profileID url:(NSString *)url success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add Feed URL to parameters
    [parameters addEntriesFromDictionary:@{ @"parameters[feed_url]" : url }];
    
    // Add Type to parameters
    [parameters addEntriesFromDictionary:@{ @"type" : @"rss" }];
    
    // Send icon true to get API to fetch details
    [parameters addEntriesFromDictionary:@{ @"icon" : @true }];
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/imports/create.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Delete Import

- (void)deleteImportForProfile:(NSString *)profileID importID:(NSString *)importID success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add feed id to parameters
    [parameters addEntriesFromDictionary:@{ @"id" : importID }];
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/imports/destroy.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Add Import Post

- (void)addImportPost:(BKImportPost *)post profiles:(NSArray *)profileIDs success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"text" : [post text] }];
    
    // Add Profiles to parameters
    [parameters addEntriesFromDictionary:@{@"profile_ids" : profileIDs}];
    
    /*
    // Add media to parameters
    if([post.media valueForKey:@"images"] && [[post.media valueForKey:@"images"] count] != 0){
        [parameters addEntriesFromDictionary:@{@"media[thumbnail]" : [[post.media valueForKey:@"images"] objectAtIndex:0]}];
        [parameters addEntriesFromDictionary:@{@"media[photo]" : [[post.media valueForKey:@"images"] objectAtIndex:0]}];
    }
     */
    
    // Import ID
    [parameters addEntriesFromDictionary:@{@"import_item_id" : post.importItemID}];
    
    [self createUpdateWithParamters:parameters success:success failure:failure];
}

#pragma mark - Dismiss Import Post

- (void)dismissImportPostForProfile:(NSString *)profileID import:(BKImportPost *)post success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"import_item_id": post.importItemID, @"profile_ids": @[profileID]};
    
    [self POST:[NSString stringWithFormat:@"user/imports/dismiss.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end

