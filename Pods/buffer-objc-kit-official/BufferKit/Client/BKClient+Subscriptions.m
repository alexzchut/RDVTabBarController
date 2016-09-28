//
//  BKClient+Subscriptions.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 04/06/2015.
//  Copyright (c) 2015 Andrew Yates. All rights reserved.
//

#import "BKClient+Subscriptions.h"

@implementation BKClient (Subscriptions)

- (void)addSubscription:(NSString *)receipt price:(NSString *)price locale:(NSString *)locale success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self addSubscription:receipt price:price locale:locale sandbox:NO success:success failure:failure];
}

- (void)addSubscription:(NSString *)receipt price:(NSString *)price locale:(NSString *)locale sandbox:(BOOL)sandbox success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self addSubscription:receipt price:price currency:@"" locale:locale sandbox:sandbox success:success failure:failure];
}

- (void)addSubscription:(NSString *)receipt price:(NSString *)price currency:(NSString *)currency locale:(NSString *)locale sandbox:(BOOL)sandbox success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add Receipt
    [parameters addEntriesFromDictionary:@{ @"receipt" : receipt }];
    
    if (price) {
        [parameters addEntriesFromDictionary:@{ @"price" : price }];
    }
    
    if(currency){
        [parameters addEntriesFromDictionary:@{ @"price_currency_code" : currency }];
    }
    
    if(locale){
        [parameters addEntriesFromDictionary:@{ @"price_locale" : locale }];
    }
        
    if(sandbox){
        [parameters addEntriesFromDictionary:@{ @"testflight": @YES }];
    }
        
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"https://api.bufferapp.com/i/user/add_subscription.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
