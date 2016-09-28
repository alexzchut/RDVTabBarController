//
//  BKClient+Links.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (Links)

- (void)shortenLink:(NSString *)link success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getLinkInfo:(NSString *)link success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getLinkInfo:(NSString *)link filters:(NSDictionary *)filters success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
