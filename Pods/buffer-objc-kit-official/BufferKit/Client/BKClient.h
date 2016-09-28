//
//  BKClient.h
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "AFNetworking.h"

@interface BKClient : AFHTTPSessionManager

+ (NSURL *)APIBaseURL;
+ (BKClient *)sharedClient;

@property (assign, nonatomic) NSInteger perPage;
@property (readonly) NSString *accessToken;

// Instance-based access token setter
- (void)setAccessToken:(NSString *)accessToken;

@end
