//
//  BKClient+Upload.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 08/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+Upload.h"

@implementation BKClient (Upload)

- (void)uploadImage:(NSData *)imageData progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"upload.json?access_token=%@", self.accessToken] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"media[picture]" fileName:@"12345" mimeType:@"image/jpeg"];
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)uploadImageWithKey:(NSString *)imageKey progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/upload_image.json?access_token=%@", self.accessToken];
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"key" : imageKey }];
    
    [self POST:path parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)uploadVideo:(NSString *)videoKey progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/upload_video.json?access_token=%@", self.accessToken];
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"key" : videoKey }];
    
    [self POST:path parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
