//
//  BKClient+BKInfo.m
//  BufferKit
//
//  Created by Andrew Yates on 01/04/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+Info.h"

@implementation BKClient (Info)

#pragma mark - Client

- (void)getClientWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"info/client.json?access_token=%@", self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Configuration

- (void)getConfigurationWithSuccess:(void (^)(BKConfiguration *configuration))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"info/configuration.json?access_token=%@", self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BKConfiguration *configuration = [MTLJSONAdapter modelOfClass:BKConfiguration.class fromJSONDictionary:responseObject error:NULL];
        success(configuration);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Timezones

- (void)getTimezonesWithSuccess:(void (^)(NSArray *timezones))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"info/timezones.json?access_token=%@", self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *timezones = (NSArray *)responseObject[@"suggestions"];
        NSMutableArray *results = [NSMutableArray new];
        for (NSDictionary *tzDictionary in timezones) {
            if (tzDictionary[@"timezone"]) {
                [results addObject:tzDictionary[@"timezone"]];
            }
        }

        success(timezones);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getTimezonesWithQuery:(NSString *)query success:(void (^)(NSArray *timezones))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"q" : query};

    [self GET:[NSString stringWithFormat:@"info/timezones.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *timezones = (NSArray *)responseObject[@"suggestions"];
        NSMutableArray *results = [NSMutableArray new];
        for (NSDictionary *tzDictionary in timezones) {
            if (tzDictionary[@"timezone"]) {
                [results addObject:tzDictionary[@"timezone"]];
            }
        }
        success(timezones);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Application Modes

- (void)getApplicationModesWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/info/application_modes.json?comprehensive=true&access_token=%@", self.accessToken];
    
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
