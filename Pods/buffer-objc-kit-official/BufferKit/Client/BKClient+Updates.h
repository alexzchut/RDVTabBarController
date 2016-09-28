//
//  BKClient+Updates.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 07/08/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKClient.h"
#import "BKRetweetData.h"
#import "BKUpdate.h"

@interface BKClient (Updates)

typedef enum BFRUpdatesCreateSaveOption : NSInteger BFRUpdatesCreateSaveOption;
enum BFRUpdatesCreateSaveOption : NSInteger {
    BFRUpdatesCreateSaveOptionBuffer,
    BFRUpdatesCreateSaveOptionShareNow,
    BFRUpdatesCreateSaveOptionShareNext,
    BFRUpdatesCreateSaveOptionSave
};

#pragma mark - Approve

- (void)approveUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Create

- (void)createUpdateWithText:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createUpdateWithText:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createUpdateWithText:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createUpdateWithText:(NSString *)text facebookText:(NSString *)facebookText media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createUpdateWithText:(NSString *)text facebookText:(NSString *)facebookText media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL importItemID:(NSString *)importItemID shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createUpdateWithText:(NSString *)text facebookText:(NSString *)facebookText keepAttachment:(BOOL)keepAttachment media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles subprofiles:(NSArray *)subprofiles sourceURL:(NSString *)sourceURL importItemID:(NSString *)importItemID shorten:(BOOL)shorten success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


- (void)createUpdateWithTweet:(BKRetweetData *)retweet media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia comment:(NSString *)comment facebookText:(NSString *)facebookText time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createUpdateWithTweet:(BKRetweetData *)retweet time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option profiles:(NSArray *)profiles success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)createUpdateWithParamters:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Update

- (void)editUpdate:(BKUpdate *)update text:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)editUpdate:(BKUpdate *)update text:(NSString *)text media:(NSDictionary *)media time:(NSDate *)time sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)editUpdate:(BKUpdate *)update text:(NSString *)text media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia time:(NSDate *)time sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)editUpdate:(BKUpdate *)update text:(NSString *)text keepAttachment:(BOOL)keepAttachment  media:(NSDictionary *)media extraMedia:(NSDictionary *)extraMedia subProfileId:(NSString *)subProfileId time:(NSDate *)time sourceURL:(NSString *)sourceURL shorten:(BOOL)shorten saveOption:(BFRUpdatesCreateSaveOption)option success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Destroy

- (void)destroyUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Share

- (void)shareUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Requeue

- (void)requeueUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Move to Top

- (void)moveToTopUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Interactions

#pragma mark - Create Interaction

#pragma mark - Read

- (void)getUpdate:(NSString *)updateID success:(void (^)(BKUpdate *update))success failure:(void (^)(NSError *error))failure;

#pragma mark - Retweet Data

- (void)getRetweetDataForProfile:(NSString *)profileID tweet:(NSString *)tweetID success:(void (^)(BKRetweetData *retweetData))success failure:(void (^)(NSError *error))failure;

#pragma mark - Convert to Quote

- (void)convertToQuoteUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

#pragma mark - Notification Acknowledgment

- (void)acknowledgeNotificationForUpdate:(NSString *)updateID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
