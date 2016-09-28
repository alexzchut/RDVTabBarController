//
//  BKClient+ProfileSettings.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKTeamMember.h"
#import "BKSchedule.h"
#import "BKShortener.h"
#import "BKProfile.h"

@interface BKClient (ProfileSettings)

- (void)getSchedulesForProfile:(NSString *)profileID success:(void (^)(NSArray *schedules))success failure:(void (^)(NSError *error))failure;

- (void)setSchedulesForProfile:(NSString *)profileID schedule:(NSArray *)schedule success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)setTimezoneForProfile:(NSString *)profileID timezone:(NSString *)timezone city:(NSString *)city success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


- (void)getTeamMembersForProfile:(NSString *)profileID success:(void (^)(NSArray *teamMembers))success failure:(void (^)(NSError *error))failure;

- (void)addTeamMemberToProfile:(NSString *)profileID email:(NSString *)email role:(NSString *)role success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)editTeamMemberToProfile:(NSString *)profileID user:(NSString *)userID email:(NSString *)email role:(NSString *)role success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)deleteTeamMemberToProfile:(NSString *)profileID user:(NSString *)userID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


- (void)getShortenersForProfile:(NSString *)profileID success:(void (^)(NSArray *shorteners))success failure:(void (^)(NSError *error))failure;

- (void)setShortenerForProfile:(NSString *)profileID domain:(NSString *)domain success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)destroyProfile:(NSString *)profileID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)reorderProfilesWithOrder:(NSArray *)order success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)editProfileWithID:(NSString *)profileID defaultValue:(BOOL)newDefaultValue success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure;

@end
