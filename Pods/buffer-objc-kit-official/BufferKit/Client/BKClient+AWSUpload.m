//
//  BKClient+AWSUpload.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 17/05/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "BKClient+AWSUpload.h"
#import "XMLDictionary.h"

@implementation BKClient (AWSUpload)

- (void)uploadImage:(NSData *)imageData progress:(void (^)(NSProgress *))uploadProgress fileName:(NSString *)filename userID:(NSString *)userID s3ImageSignature:(NSDictionary *)signature success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Key
    NSTimeInterval time = [[NSDate new] timeIntervalSince1970];
    NSString *intervalString = [NSString stringWithFormat:@"%.f", floor(time/3600)];
    NSString *key = [NSString stringWithFormat:@"%@/uploads/%@-%@", userID, intervalString, filename];
    
    [parameters addEntriesFromDictionary:@{ @"key" : key }];
    
    // Content Type
    [parameters addEntriesFromDictionary:@{ @"Content-Type": [self mimeTypeForData:imageData] }];
    
    // ACL
    [parameters addEntriesFromDictionary:@{ @"acl": @"public-read" }];
    
    // Success Action
    [parameters addEntriesFromDictionary:@{ @"success_action_status": [signature valueForKey:@"success_action_status"] }];
    
    // Policy
    [parameters addEntriesFromDictionary:@{ @"policy": [signature valueForKey:@"base64policy"] }];
    
    // AMZ Algorithm
    [parameters addEntriesFromDictionary:@{ @"X-amz-algorithm": [signature valueForKey:@"algorithm"] }];
    
    // AMZ Credential
    [parameters addEntriesFromDictionary:@{ @"X-amz-credential": [signature valueForKey:@"credentials"] }];
    
    // AMZ Expires
    [parameters addEntriesFromDictionary:@{ @"X-amz-expires": [signature valueForKey:@"expires"] }];
    
    // AMZ Date
    [parameters addEntriesFromDictionary:@{ @"X-amz-date" : [signature valueForKey:@"date"] }];
    
    // AMZ Signature
    [parameters addEntriesFromDictionary:@{ @"X-amz-signature": [signature valueForKey:@"signature"] }];
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://%@.s3.amazonaws.com", [signature valueForKey:@"bucket"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:filename mimeType:[self mimeTypeForData:imageData]];
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = (NSData *)responseObject;
        NSString  *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *xmlDictionary = [NSDictionary dictionaryWithXMLString:responseString];
        success(xmlDictionary);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)uploadVideo:(NSData *)videoData progress:(void (^)(NSProgress *))uploadProgress fileName:(NSString *)filename userID:(NSString *)userID s3VideoSignature:(NSDictionary *)signature success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Key
    NSTimeInterval time = [[NSDate new] timeIntervalSince1970];
    NSString *intervalString = [NSString stringWithFormat:@"%.f", floor(time/3600)];
    NSString *key = [NSString stringWithFormat:@"%@/uploads/%@-%@", userID, intervalString, filename];
    
    [parameters addEntriesFromDictionary:@{ @"key" : key }];
    
    // Content Type
    [parameters addEntriesFromDictionary:@{ @"Content-Type": @"video/mp4" }];
    
    // ACL
    [parameters addEntriesFromDictionary:@{ @"acl": @"public-read" }];
    
    // Success Action
    [parameters addEntriesFromDictionary:@{ @"success_action_status": [signature valueForKey:@"success_action_status"] }];
    
    // Policy
    [parameters addEntriesFromDictionary:@{ @"policy": [signature valueForKey:@"base64policy"] }];
    
    // AMZ Algorithm
    [parameters addEntriesFromDictionary:@{ @"X-amz-algorithm": [signature valueForKey:@"algorithm"] }];
    
    // AMZ Credential
    [parameters addEntriesFromDictionary:@{ @"X-amz-credential": [signature valueForKey:@"credentials"] }];
    
    // AMZ Expires
    [parameters addEntriesFromDictionary:@{ @"X-amz-expires": [signature valueForKey:@"expires"] }];
    
    // AMZ Date
    [parameters addEntriesFromDictionary:@{ @"X-amz-date" : [signature valueForKey:@"date"] }];
    
    // AMZ Signature
    [parameters addEntriesFromDictionary:@{ @"X-amz-signature": [signature valueForKey:@"signature"] }];
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://%@.s3.amazonaws.com", [signature valueForKey:@"bucket"]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:videoData name:@"file" fileName:filename mimeType:@"video/mp4"];
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = (NSData *)responseObject;
        NSString  *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *xmlDictionary = [NSDictionary dictionaryWithXMLString:responseString];
        success(xmlDictionary);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (NSString *)mimeTypeForData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
            break;
        case 0x89:
            return @"image/png";
            break;
        case 0x47:
            return @"image/gif";
            break;
        default:
            return @"image/jpeg";
    }
    return nil;
}

@end
