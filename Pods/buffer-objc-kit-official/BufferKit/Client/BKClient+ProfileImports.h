//
//  BKClient+ProfileImports.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKImport.h"
#import "BKImportPost.h"

@interface BKClient (ProfileImports)

- (void)getImportsForProfile:(NSString *)profileID success:(void (^)(NSArray *imports))success failure:(void (^)(NSError *error))failure;

- (void)getImportPostsForProfile:(NSString *)profileID import:(NSString *)importID page:(NSString *)page success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)addImportForProfile:(NSString *)profileID url:(NSString *)url success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)deleteImportForProfile:(NSString *)profileID importID:(NSString *)importID success:(void (^)(NSArray *updates))success failure:(void (^)(NSError *error))failure;

- (void)addImportPost:(BKImportPost *)post profiles:(NSArray *)profileIDs success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)dismissImportPostForProfile:(NSString *)profileID import:(BKImportPost *)post success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
