//
//  BKProfile.h
//  BufferKitDemo
//
//  Created by Andrew Yates on 16/07/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "Mantle.h"

@interface BKProfile : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSString *profileID;

@property (nonatomic, copy, readonly) NSURL *avatarHTTP;
@property (nonatomic, copy, readonly) NSURL *avatarHTTPS;
@property (nonatomic, copy, readonly) NSDictionary *counts;
@property (nonatomic, readonly) BOOL isDefault;
@property (nonatomic, readonly) BOOL isDisabled;
@property (nonatomic, copy, readonly) NSString *formattedService;
@property (nonatomic, copy, readonly) NSString *formattedUsername;
@property (nonatomic, copy, readonly) NSDictionary *limits;
@property (nonatomic, copy, readonly) NSArray *permissions;
@property (nonatomic, copy, readonly) NSArray *planFeatures;
@property (nonatomic, copy, readonly) NSDictionary *preferences;
@property (nonatomic, copy, readonly) NSDictionary *schedules;
@property (nonatomic, copy, readonly) NSString *service;
@property (nonatomic, copy, readonly) NSString *serviceID;
@property (nonatomic, copy, readonly) NSString *serviceUsername;
@property (nonatomic, copy, readonly) NSString *serviceType;
@property (nonatomic, copy, readonly) NSString *serviceVerb;
@property (nonatomic, copy, readonly) NSString *shortener;
@property (nonatomic, copy, readonly) NSArray *subprofiles;
@property (nonatomic, copy, readonly) NSDictionary *teamMembers;
@property (nonatomic, copy, readonly) NSString *timezone;
@property (nonatomic, copy, readonly) NSString *timezoneCity;
@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *verb;

@end
