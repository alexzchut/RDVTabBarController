//
//  BKClient+ProfileGroups.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKProfileGroup.h"

@interface BKClient (ProfileGroups)

- (void)getProfileGroupsWithSuccess:(void (^)(NSArray *profileGroups))success failure:(void (^)(NSError *error))failure;

- (void)addProfileGroupWithName:(NSString *)name profiles:(NSArray *)profileIDs success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)editProfileGroupWithID:(NSString *)groupID name:(NSString *)name profiles:(NSArray *)profileIDs success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)deleteProfileGroupWithID:(NSString *)groupID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
