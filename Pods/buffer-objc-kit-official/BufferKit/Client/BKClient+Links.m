//
//  BKClient+Links.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+Links.h"

@implementation BKClient (Links)

#pragma mark - Shorten

- (void)shortenLink:(NSString *)link success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSString *urlString = [NSString stringWithFormat:@"%@", link];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"Http://" withString:@""];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters addEntriesFromDictionary:@{ @"url" : urlString }];
    
    [self GET:[NSString stringWithFormat:@"links/shorten.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getLinkInfo:(NSString *)link success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self getLinkInfo:link filters:nil success:success failure:failure];
}

- (void)getLinkInfo:(NSString *)link filters:(NSDictionary *)filters success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // Are we getting info for a short link?
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:link] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:15.0f];
    
    [request setHTTPMethod:@"HEAD"];
    
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.6 Safari/537.11" forHTTPHeaderField:@"User-Agent"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *parameters = [filters mutableCopy];
        
        if(error){
            [parameters addEntriesFromDictionary:@{ @"url" : link }];
            
            // Looks like the request failed. Fallback to fetching link info using the short link.
            [self GET:[NSString stringWithFormat:@"links/info.json?access_token=%@", self.accessToken] parameters:filters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        } else {
            // We got a resolved URL, lets use that to get link info.
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
            NSURL *resolvedURL = [httpResponse URL];

            [parameters addEntriesFromDictionary:@{ @"url" : resolvedURL.absoluteString }];

            [self GET:[NSString stringWithFormat:@"links/info.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
    }];
}

@end
