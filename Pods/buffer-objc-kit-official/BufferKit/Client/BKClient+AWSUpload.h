//
//  BKClient+AWSUpload.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 17/05/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (AWSUpload)

- (void)uploadVideo:(NSData *)videoData progress:(void (^)(NSProgress *))uploadProgress fileName:(NSString *)filename userID:(NSString *)userID s3VideoSignature:(NSDictionary *)signature success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)uploadImage:(NSData *)imageData progress:(void (^)(NSProgress *))uploadProgress fileName:(NSString *)filename userID:(NSString *)userID s3ImageSignature:(NSDictionary *)signature success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
