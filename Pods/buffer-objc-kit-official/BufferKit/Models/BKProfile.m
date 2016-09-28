//
//  BKProfile.m
//  BufferKitDemo
//
//  Created by Andrew Yates on 16/07/2014.
//  Copyright (c) 2014 Andrew Yates. All rights reserved.
//

#import "BKProfile.h"
#import "BKSubprofile.h"

@implementation BKProfile

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"profileID": @"id",
             @"avatarHTTP": @"avatar",
             @"avatarHTTPS": @"avatar_https",
             @"counts": @"counts",
             @"isDefault": @"default",
             @"isDisabled": @"disabled",
             @"formattedService": @"formatted_service",
             @"formattedUsername": @"formatted_username",
             @"limits": @"limits",
             @"permissions": @"permissions",
             @"planFeatures": @"plan_features",
             @"preferences": @"preferences",
             @"schedules": @"schedules",
             @"service": @"service",
             @"serviceID": @"service_id",
             @"serviceUsername": @"service_username",
             @"serviceType": @"service_type",
             @"serviceVerb": @"verb",
             @"shortener": @"shortener.domain",
             @"subprofiles": @"subprofiles",
             @"teamMembers": @"team_members",
             @"timezone": @"timezone",
             @"timezoneCity": @"timezone_city",
             @"userID": @"user_id",
             @"verb": @"verb",
             };
}

+ (NSValueTransformer *)avatarHTTPJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)avatarHTTPSJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)subprofilesJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[BKSubprofile class]];
}

@end
