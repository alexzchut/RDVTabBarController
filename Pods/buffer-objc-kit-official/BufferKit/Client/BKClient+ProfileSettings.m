//
//  BKClient+ProfileSettings.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+ProfileSettings.h"

@implementation BKClient (ProfileSettings)

#pragma mark - Schedules

- (void)getSchedulesForProfile:(NSString *)profileID success:(void (^)(NSArray *schedules))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/schedules.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *schedules = [MTLJSONAdapter modelsOfClass:BKSchedule.class fromJSONArray:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(schedules);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)setSchedulesForProfile:(NSString *)profileID schedule:(NSArray *)schedule success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    for (int i = 0; i < [schedule count]; i++) {
        
        if([[schedule objectAtIndex:i] valueForKey:@"days"] && [[schedule objectAtIndex:i] valueForKey:@"times"]){
            NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:[[schedule objectAtIndex:i] valueForKey:@"days"] , [NSString stringWithFormat:@"schedules[%i][days]",i], [[schedule objectAtIndex:i] valueForKey:@"times"] , [NSString stringWithFormat:@"schedules[%i][times]",i], nil];
            [parameters addEntriesFromDictionary:tmpDict];
        } else if([[schedule objectAtIndex:i] valueForKey:@"days"]){
            NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:[[schedule objectAtIndex:i] valueForKey:@"days"] , [NSString stringWithFormat:@"schedules[%i][days]",i], nil];
            [parameters addEntriesFromDictionary:tmpDict];
        } else if([[schedule objectAtIndex:i] valueForKey:@"times"]){
            NSDictionary *tmpDict = [NSDictionary dictionaryWithObjectsAndKeys:[[schedule objectAtIndex:i] valueForKey:@"times"] , [NSString stringWithFormat:@"schedules[%i][times]",i], nil];
            [parameters addEntriesFromDictionary:tmpDict];
        }
    }
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/schedules/update.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


#pragma mark - Team Members

- (void)getTeamMembersForProfile:(NSString *)profileID success:(void (^)(NSArray *teamMembers))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/team.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *teamMembers = [MTLJSONAdapter modelsOfClass:BKTeamMember.class fromJSONArray:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(teamMembers);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)addTeamMemberToProfile:(NSString *)profileID email:(NSString *)email role:(NSString *)role success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add Email to parameters
    [parameters addEntriesFromDictionary:@{ @"team_member_email" : email }];
    
    // Add Role to parameters
    [parameters addEntriesFromDictionary:@{ @"role" : role }];
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/team/create.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)editTeamMemberToProfile:(NSString *)profileID user:(NSString *)userID email:(NSString *)email role:(NSString *)role success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add User ID
    [parameters addEntriesFromDictionary:@{ @"team_member_user_id" : userID }];
    
    // Add Email to parameters
    [parameters addEntriesFromDictionary:@{ @"team_member_email" : email }];
    
    // Add Role to parameters
    [parameters addEntriesFromDictionary:@{ @"role" : role }];
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/team/update.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)deleteTeamMemberToProfile:(NSString *)profileID user:(NSString *)userID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add User to parameters
    [parameters addEntriesFromDictionary:@{ @"team_member_user_id" : userID }];
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/team/destroy.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Shorteners

- (void)getShortenersForProfile:(NSString *)profileID success:(void (^)(NSArray *shorteners))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"profiles/%@/shorteners.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        NSArray *shorteners = [MTLJSONAdapter modelsOfClass:BKShortener.class fromJSONArray:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(shorteners);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)setShortenerForProfile:(NSString *)profileID domain:(NSString *)domain success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = @{@"domain" : domain};
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/shorteners/update.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Timezone

- (void)setTimezoneForProfile:(NSString *)profileID timezone:(NSString *)timezone city:(NSString *)city success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSDictionary *parameters = @{ @"timezone" : timezone, @"timezone_city" : city };
    
    [self POST:[NSString stringWithFormat:@"profiles/%@/update_timezone.json?access_token=%@", profileID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - UTM Tracking

#pragma mark - Destroy

- (void)destroyProfile:(NSString *)profileID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"profiles/%@/destroy.json?access_token=%@", profileID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Reorder

- (void)reorderProfilesWithOrder:(NSArray *)order success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"order":order};
    
    [self POST:[NSString stringWithFormat:@"profiles/reorder.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Update 

- (void)editProfileWithID:(NSString *)profileID defaultValue:(BOOL)newDefaultValue success:(void (^)(BKProfile *profile))success failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    parameters[@"default"] = newDefaultValue ? @YES : @NO;
    
    NSString *urlString = [NSString stringWithFormat:@"profiles/%@/update.json?access_token=%@", profileID, self.accessToken];
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        if ([responseDict[@"success"] isEqual:@YES]) {
            // Successful update response
            NSError *error = nil;
            BKProfile *profile = [MTLJSONAdapter modelOfClass:BKProfile.class fromJSONDictionary:responseDict[@"profile"] error:&error];
            if(error){
                failure(error);
                return;
            }
            success(profile);
        } else {
            // Unsucessful update response
            success(nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
