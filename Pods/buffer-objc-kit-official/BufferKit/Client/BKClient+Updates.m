//
//  BKClient+Updates.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient+Updates.h"
#import "BKClientErrorBuilder.h"

@implementation BKClient (Updates)

#pragma mark - Approve

- (void)approveUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"updates/%@/approve.json?access_token=%@", updateID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Create

- (void)createUpdateWithText:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self createUpdateWithText:text media:media time:time saveOption:option profiles:profiles shorten:YES success:success failure:failure];
}

- (void)createUpdateWithText:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self createUpdateWithText:text media:media time:time saveOption:option profiles:profiles subprofiles:nil sourceURL:nil shorten:shorten success:success failure:failure];
}

- (void)createUpdateWithText:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self createUpdateWithText:text facebookText:nil media:media time:time saveOption:option profiles:profiles subprofiles:subprofiles sourceURL:sourceURL shorten:shorten success:success failure:failure];
}

- (void)createUpdateWithText:(NSString *)text facebookText:(NSString *)facebookText media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
}

- (void)createUpdateWithText:(NSString *)text facebookText:(NSString *)facebookText media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL importItemID:(NSString *)importItemID shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self createUpdateWithText:text facebookText:facebookText keepAttachment:YES media:media extraMedia:nil time:time saveOption:option profiles:profiles subprofiles:subprofiles sourceURL:sourceURL importItemID:importItemID shorten:shorten success:success failure:failure];
}

- (void)createUpdateWithText:(NSString *)text facebookText:(NSString *)facebookText keepAttachment:(BOOL)keepAttachment media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL importItemID:(NSString *)importItemID shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"text" : text }];
    
    if(facebookText){
        [parameters addEntriesFromDictionary:@{ @"fb_text" : facebookText }];
    }
    
    // If update is to be shared now add now parameter
    if(option == BFRUpdatesCreateSaveOptionShareNow){
        [parameters addEntriesFromDictionary:@{@"now" : @YES}];
    }
    
    // If update is to be shared next
    if(option == BFRUpdatesCreateSaveOptionShareNext){
        [parameters addEntriesFromDictionary:@{@"top": @YES}];
    }
    
    // Disable shortening if NO
    if(!shorten){
        [parameters addEntriesFromDictionary:@{@"shorten": @"false"}];
    }
    
    // Add Profiles to parameters
    [parameters addEntriesFromDictionary:@{@"profile_ids" : profiles}];
    
    // Add Subprofiles to parameters
    if(subprofiles){
        [parameters addEntriesFromDictionary:@{@"subprofile_ids" : subprofiles}];
    }
    
    // Add Source URL
    if(sourceURL){
        [parameters addEntriesFromDictionary:@{@"source_url" : sourceURL}];
    }
    
    // Add Import Item ID
    if(importItemID){
        [parameters addEntriesFromDictionary:@{@"import_item_id" : importItemID}];
    }
    
    // Add Custom Scheduling time to parameters
    if(time){
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [outputFormatter setTimeZone:timeZone];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *utcDate = [outputFormatter stringFromDate:time];
        
        if (utcDate) {
            [parameters addEntriesFromDictionary:@{@"scheduled_at" : utcDate}];
        } else {
            // Mark it as a failure
            // See: https://github.com/bufferapp/buffer-ios/issues/584
            NSError *error = [BKClientErrorBuilder errorForCustomScheduleTimeFailure:time];
            failure(error);
            return;
        }
    }
    
    // Add media to parameters
    if([media isKindOfClass:[NSDictionary class]]){
        [parameters addEntriesFromDictionary:media];
    }
    
    // Add extraMedia to parameters
    if([extraMedia isKindOfClass:[NSDictionary class]]){
        [parameters addEntriesFromDictionary:extraMedia];
    }
    
    // If they deleted the link attachment
    if (!keepAttachment) {
        [parameters setObject:@"false" forKey:@"attachment"];
    }
    
    [self createUpdateWithParamters:parameters success:success failure:failure];
}

- (void)createUpdateWithTweet:(BKRetweetData *)retweet time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self createUpdateWithTweet:retweet time:time saveOption:option profiles:profiles success:success failure:failure];
}

- (void)createUpdateWithTweet:(BKRetweetData *)retweet media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia comment:(NSString *)comment facebookText:(NSString *)facebookText time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add default text if they didn't send any
    if (!comment || [comment isEqualToString:@""]) {
        NSString *quoteText = [NSString stringWithFormat:@"RT @%@: %@", retweet.screenname, retweet.text];
        [parameters addEntriesFromDictionary:@{ @"text" : quoteText }];
    } else {
        [parameters addEntriesFromDictionary:@{ @"text" : comment }];
    }
    
    // If update is to be shared now add now parameter
    if(option == BFRUpdatesCreateSaveOptionShareNow){
        [parameters addEntriesFromDictionary:@{@"now" : @YES}];
    }
    
    // If update is to be shared next
    if(option == BFRUpdatesCreateSaveOptionShareNext){
        [parameters addEntriesFromDictionary:@{@"top": @YES}];
    }
    
    // Add Profiles to parameters
    [parameters addEntriesFromDictionary:@{@"profile_ids" : profiles}];
    
    // Add Custom Scheduling time to parameters
    if(time){
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [outputFormatter setTimeZone:timeZone];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *utcDate = [outputFormatter stringFromDate:time];

        if (utcDate) {
            [parameters addEntriesFromDictionary:@{@"scheduled_at" : utcDate}];
        } else {
            // Mark it as a failure
            // See: https://github.com/bufferapp/buffer-ios/issues/584
            NSError *error = [BKClientErrorBuilder errorForCustomScheduleTimeFailure:time];
            failure(error);
            return;
        }
    }
    
    // Add Retweet Params
    if(comment){
        [parameters addEntriesFromDictionary:@{@"retweet[comment]" : comment}];
    }
    
    if ([retweet avatarHTTP] && [retweet avatarHTTPS]) {
        [parameters addEntriesFromDictionary:@{@"retweet[avatars]" : @{@"http":[retweet avatarHTTP], @"https":[retweet avatarHTTPS]}}];
    }
    
    if ([retweet createdAt]) {
        [parameters addEntriesFromDictionary:@{@"retweet[created_at_string]" : [retweet createdAt]}];
    }
    
    if ([retweet name]) {
        [parameters addEntriesFromDictionary:@{@"retweet[profile_name]" : [retweet name]}];
    }
    
    if ([retweet text]) {
        [parameters addEntriesFromDictionary:@{@"retweet[text]" : [retweet text]}];
    }
    
    if ([retweet tweetID]) {
        [parameters addEntriesFromDictionary:@{@"retweet[tweet_id]" : [retweet tweetID]}];
    }
    
    [parameters addEntriesFromDictionary:@{@"retweet[url]" : [NSString stringWithFormat:@"https://twitter.com/%@/status/%@", [retweet screenname], [retweet tweetID]]}];
    
    if ([retweet userID]) {
        [parameters addEntriesFromDictionary:@{@"retweet[user_id]" : [retweet userID]}];
    }
    
    if ([retweet screenname]) {
        [parameters addEntriesFromDictionary:@{@"retweet[username]" : [retweet screenname]}];
    }
    
    //Social networks besides Twitter post Retweet data differently
    if ([retweet tweetURL]) {
        
        //Somtimes mantle morphs this into an array instead of a URL
        if ([[retweet tweetURL] isKindOfClass:[NSArray class]]) {
            [parameters addEntriesFromDictionary:@{@"media[link]" : ((NSArray *)[retweet tweetURL]).firstObject}];
        } else {
            [parameters addEntriesFromDictionary:@{@"media[link]" : [retweet tweetURL]}];
        }
        
        [parameters addEntriesFromDictionary:@{@"media[title]" : @"Twitter"}];
        
        if (facebookText) {
            [parameters setObject:facebookText forKey:@"fb_text"];
        }
    }

    // Add media to parameters
    if([media isKindOfClass:[NSDictionary class]]){
        [parameters addEntriesFromDictionary:media];
    }
    
    // Add extraMedia to parameters
    if([extraMedia isKindOfClass:[NSDictionary class]]){
        [parameters addEntriesFromDictionary:extraMedia];
    }
    
    [self createUpdateWithParamters:parameters success:success failure:failure];
    
}

- (void)createUpdateWithParamters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"updates/create.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Update

- (void)editUpdate:(BKUpdate *)update text:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self editUpdate:update text:text media:media time:time sourceURL:nil shorten:YES saveOption:option success:success failure:failure];
}

- (void)editUpdate:(BKUpdate *)update text:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self editUpdate:update text:text media:media extraMedia:nil time:time sourceURL:sourceURL shorten:shorten saveOption:option success:success failure:failure];
}

- (void)editUpdate:(BKUpdate *)update text:(NSString *)text media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia time:(NSDate *)time sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self editUpdate:update text:text keepAttachment:YES media:media extraMedia:extraMedia subProfileId:nil time:time sourceURL:sourceURL shorten:shorten saveOption:option success:success failure:failure];
}
- (void)editUpdate:(BKUpdate *)update text:(NSString *)text keepAttachment:(BOOL)keepAttachment media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia subProfileId:(NSString *)subProfileId time:(NSDate *)time sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    // Set up paramaters
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    // Add text to parameters
    [parameters addEntriesFromDictionary:@{ @"text" : text }];
    
    // If update is to be shared now add now parameter
    if(option == BFRUpdatesCreateSaveOptionShareNow){
        [parameters addEntriesFromDictionary:@{@"now" : @YES}];
    }
    
    // If update is to be shared next
    if(option == BFRUpdatesCreateSaveOptionShareNext){
        [parameters addEntriesFromDictionary:@{@"top": @YES}];
    }
    
    // Disable shortening if NO
    if(!shorten){
        [parameters addEntriesFromDictionary:@{@"shorten": @"false"}];
    }
    
    // Add Source URL
    if(sourceURL){
        [parameters addEntriesFromDictionary:@{@"source_url" : sourceURL}];
    }
    
    // Add subprofile Id. For pinterest updates
    if (subProfileId) {
        [parameters addEntriesFromDictionary:@{@"subprofile_id" : subProfileId}];
    }
    
    // Add Custom Scheduling time to parameters
    if(time){
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [outputFormatter setTimeZone:timeZone];
        [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *utcDate = [outputFormatter stringFromDate:time];
        
        [parameters addEntriesFromDictionary:@{@"scheduled_at" : utcDate}];
    } else if(update.scheduledDate && !time){
        [parameters addEntriesFromDictionary:@{@"scheduled_at" : @""}];
    }
    
    // Add media to parameters
    if([media isKindOfClass:[NSDictionary class]]){
        [parameters addEntriesFromDictionary:media];
    }
    
    // Add extraMedia to parameters
    if([extraMedia isKindOfClass:[NSDictionary class]]){
        [parameters addEntriesFromDictionary:extraMedia];
    }
    
    // If they deleted the link attachment
    if (!keepAttachment) {
        [parameters setObject:@"false" forKey:@"attachment"];
    }
    
    //Account for quoted retweets, where we set the text == retweet[comment]
    if (update.retweet) {
        [parameters addEntriesFromDictionary:@{@"retweet[comment]":text}];
    }
    
    [self editUpdate:update parameters:parameters success:success failure:failure];
}

- (void)editUpdate:(BKUpdate *)update parameters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"updates/update/%@.json?access_token=%@", update.updateID, self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Destroy

- (void)destroyUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"updates/%@/destroy.json?access_token=%@", updateID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Share

- (void)shareUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"updates/%@/share.json?access_token=%@", updateID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Requeue

- (void)requeueUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"updates/%@/requeue.json?access_token=%@", updateID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Move to Top

- (void)moveToTopUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self POST:[NSString stringWithFormat:@"updates/%@/move_to_top.json?access_token=%@", updateID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Interactions

#pragma mark - Create Interaction

#pragma mark - Read

- (void)getUpdate:(NSString *)updateID success:(void (^)(BKUpdate *update))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"updates/%@.json?access_token=%@", updateID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        BKUpdate *update = [MTLJSONAdapter modelOfClass:BKUpdate.class fromJSONDictionary:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(update);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Retweet Data

- (void)getRetweetDataForProfile:(NSString *)profileID tweet:(NSString *)tweetID success:(void (^)(BKRetweetData *retweetData))success failure:(void (^)(NSError *error))failure {
    [self GET:[NSString stringWithFormat:@"updates/retweet_data.json?access_token=%@&profile_id=%@&tweet_id=%@", self.accessToken, profileID, tweetID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        BKRetweetData *retweetData = [MTLJSONAdapter modelOfClass:BKRetweetData.class fromJSONDictionary:responseObject error:&error];
        if(error){
            failure(error);
            return;
        }
        success(retweetData);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Convert to Quote

- (void)convertToQuoteUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{@"update_id": updateID};
    
    [self POST:[NSString stringWithFormat:@"updates/convert_to_quote.json?access_token=%@", self.accessToken] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - Notification Acknowledgment

- (void)acknowledgeNotificationForUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    
    [self POST:[NSString stringWithFormat:@"updates/%@/acknowledge_notification.json?access_token=%@", updateID, self.accessToken] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}



@end
