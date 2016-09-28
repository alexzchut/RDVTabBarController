//
//  BKClient+BKInfo.h
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKConfiguration.h"

@interface BKClient (Info)

- (void)getClientWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getConfigurationWithSuccess:(void (^)(BKConfiguration *configuration))success failure:(void (^)(NSError *error))failure;

- (void)getTimezonesWithSuccess:(void (^)(NSArray *timezones))success failure:(void (^)(NSError *error))failure;
- (void)getTimezonesWithQuery:(NSString *)query success:(void (^)(NSArray *timezones))success failure:(void (^)(NSError *error))failure;

- (void)getApplicationModesWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
