//
//  BKClient+SDK.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 08/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (SDK)

- (void)getClientDetailsForClient:(NSString *)clientID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)getAuthenticationCodeForClient:(NSString *)clientID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
