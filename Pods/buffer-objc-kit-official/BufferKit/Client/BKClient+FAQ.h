//
//  BKClient+FAQ.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 20/01/2016.
//  Copyright © 2016 Andrew Yates. All rights reserved.
//

#import "BKClient.h"

@interface BKClient (FAQ)

- (void)getFAQCategoriesWithSuccess:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)getFAQCategoryWithID:(NSString *)categoryID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)getFAQQuestionWithID:(NSString *)questionID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)getFAQResultsForSearchTerm:(NSString *)term success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
- (void)postFAQVoteWithQuestion:(NSString *)questionID upvote:(BOOL)upvote success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
