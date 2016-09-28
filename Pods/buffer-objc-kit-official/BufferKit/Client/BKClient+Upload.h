//
//  BKClient+Upload.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 08/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (Upload)

- (void)uploadImage:(NSData *)imageData progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)uploadImageWithKey:(NSString *)imageKey progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)uploadVideo:(NSString *)videoKey progress:(void (^)(NSProgress *))uploadProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
 
@end
