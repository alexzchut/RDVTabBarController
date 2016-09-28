//
//  BKUpdateBase.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 17/07/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"
#import "BKSubprofile.h"

typedef NS_ENUM(NSUInteger, BKUpdateType) {
    BKUpdateTypeText,
    BKUpdateTypeLink,
    BKUpdateTypeRetweet,
    BKUpdateTypePicture
};

typedef NS_ENUM(NSUInteger, BKUpdateStatus) {
    BKUpdateStatusBuffer,
    BKUpdateStatusSent,
    BKUpdateStatusService
};

@interface BKUpdate : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *updateID;

@property (nonatomic, copy, readonly) NSDate *createdAt;
@property (nonatomic, copy, readonly) NSString *dueDay;
@property (nonatomic, copy, readonly) NSString *dueTime;
@property (nonatomic, copy, readonly) NSDate *dueDate;
@property (nonatomic, copy, readonly) NSDate *scheduledDate;

@property (nonatomic, copy, readonly) NSString *error;
@property (nonatomic, copy, readonly) NSDictionary *media;
@property (nonatomic, copy, readonly) NSArray *extraMedia;
@property (nonatomic, copy, readonly) NSString *profileID;
@property (nonatomic, copy, readonly) NSString *profileService;
@property (nonatomic, copy, readonly) NSDictionary *retweet;
@property (nonatomic, copy, readonly) NSString *status;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSString *textFormatted;
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSDate *updatedAt;
@property (nonatomic, copy, readonly) NSDictionary *user;
@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSDictionary *client;
@property (nonatomic, copy, readonly) NSString *via;
@property (nonatomic, copy, readonly) NSString *sourceURL;
@property (nonatomic, copy, readonly) NSDictionary *sharedBy;
@property (nonatomic, copy, readonly) NSString *serviceUpdateId;

@property (nonatomic, readonly) BOOL isApprovable;
@property (nonatomic, readonly) BOOL isEditable;
@property (nonatomic) BOOL isSorting;

@property (nonatomic, readonly) BOOL isTopUpdate;
@property (nonatomic, copy, readonly) NSURL *serviceLink;
@property (nonatomic, copy, readonly) NSString *serviceID;
@property (nonatomic, copy, readonly) NSDictionary *statistics;
@property (nonatomic, copy, readonly) NSDate *sentDate;

@property (nonatomic, copy, readonly) BKSubprofile *subprofile;


@end
