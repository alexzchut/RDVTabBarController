//
//  BKClient.m
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKJSONResponseSerializerWithData.h"

@implementation BKClient

@synthesize accessToken = _accessToken;

+ (BKClient *)sharedClient {
    static BKClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        // Should probably find a better way to set the dev api usage.
        // Detect if an NSUserDefault exists for BFRDevAPI and it's true.
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"BFRDevAPI"]){
            _sharedClient = [[self alloc] initWithBaseURL:[[self class] APIBaseURLDev]];
        } else {
            _sharedClient = [[self alloc] initWithBaseURL:[[self class] APIBaseURL]];
        }
        _sharedClient.perPage = 20;
        _sharedClient.responseSerializer = [BKJSONResponseSerializerWithData serializer];
        _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedClient.securityPolicy = [self bufferSecurityPolicy];
    });
    
    return _sharedClient;
}

+ (AFSecurityPolicy*)bufferSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setValidatesDomainName:YES];
    [securityPolicy setAllowInvalidCertificates:NO];
    return securityPolicy;
}

+ (NSURL *)APIBaseURL {
    return [NSURL URLWithString:@"https://api.bufferapp.com/1/"];
}

+ (NSURL *)APIBaseURLDev {
    return [NSURL URLWithString:@"http://dev.api.bufferapp.com/1/"];
}

- (void)setAccessToken:(NSString *)accessToken {
    if(accessToken == nil || [accessToken length] == 0) {
        [NSException raise:@"BKInvalidAccessToken" format:@"You have provided an invalid Buffer access token."];
    }
    
    // Logs and updates the access token.
    NSLog(@"[BufferKit] Access token set: %@", _accessToken = accessToken);
}

@end
