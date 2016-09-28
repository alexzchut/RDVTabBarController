//
//  BKClient+FAQ.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 20/01/2016.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BKClient+FAQ.h"

@implementation BKClient (FAQ)

- (void)getFAQCategoriesWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/faq/categories.json?access_token=%@", self.accessToken];
    
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getFAQCategoryWithID:(NSString *)categoryID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/faq/categories/%@/questions.json?access_token=%@", categoryID, self.accessToken];
    
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getFAQQuestionWithID:(NSString *)questionID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/faq/questions/%@.json?access_token=%@", questionID, self.accessToken];
    
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)getFAQResultsForSearchTerm:(NSString *)term success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/faq/search.json?q=%@&access_token=%@", term, self.accessToken];
    
    [self GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)postFAQVoteWithQuestion:(NSString *)questionID upvote:(BOOL)upvote success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"https://api.bufferapp.com/i/faq/questions/%@/votes.json?access_token=%@", questionID, self.accessToken];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if(upvote){
        [params addEntriesFromDictionary:@{@"type":@"up"}];
    } else {
        [params addEntriesFromDictionary:@{@"type":@"down"}];
    }
    
    [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
